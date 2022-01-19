import Text "mo:base/Text";
import Time "mo:base/Time";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

actor {
    public type Message = {
        text: Text;
        time: Time.Time;
        author: Text;
        };

    public type Microblog = actor {
        follow: shared (Principal) -> async (); // 添加关注对象
        follows: shared query () -> async [Principal]; // 返回关注列表
        post: shared (Text, Text) -> async (); // 发布新消息
        posts: shared query () -> async [Message]; //返回所有发布的消息
        timeline: shared () -> async [Message]; // 返回所有关注对象发布的消息
        set_name: shared (Text) -> async ();
        get_name: shared () -> async ?Text;
    };

    stable var followed: List.List<Principal> = List.nil();

    public shared func follow(id: Principal) : async () {
        followed := List.push(id, followed);

    };

    public shared query func follows() : async [Principal] {
        List.toArray(followed)
    };

    var messages: List.List<Message> = List.nil();

    public shared (msg) func post(otp: Text, text: Text) : async () {
        // assert(Principal.toText(msg.caller) == "jqdif-2oder-67xoh-ncrob-3mj4v-273aq-5jpme-2kxfy-p4zmb-2kvlm-vqe");
        assert(otp == "123456");
        let message = {
            text = text;
            time = Time.now();
            author = canister_name;
        };
        messages := List.push(message, messages);
    };

    public shared query func posts() : async [Message] { 
        var all: List.List<Message> = List.nil();

        for (msg in Iter.fromList(messages)) {
            all := List.push(msg, all);
        };
        List.toArray(all)
    };

    public shared func timeline() : async [Message] {
        var all: List.List<Message> = List.nil();

        for (id in Iter.fromList(followed)) {
            let canister : Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts();
            for(msg in Iter.fromArray(msgs)) {
                all := List.push(msg, all);
            };
        };
        List.toArray(all)
    };

    var canister_name: Text = "canister_name";

    public shared func set_name(name: Text) {
        canister_name := name;
    };
    
    public shared func get_name() : async ?Text {
        ?canister_name
    };
};