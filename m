Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB036B3DA8@exch-03.noida.hcltech.com>
From: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
Subject: RE: [uml-devel] uml_switch query
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 13 Jan 2005 10:09:59 +0530
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Thanks Paolo.
i have done some testing & find out that command
uml_switch -unix /tmp/uml1 -tap tap10
doesn't work as i wrote earlier but if i use the command
uml_switch -tap tap10 -unix /tmp/uml1 
it works fine. So may be the sequencing problem.
It resolves my problem that default socket file is not used & we can specify
our own socket file with -tap option.

Yes, I have tested only one tap device can be attached with a uml switch.

Thanks and Best Regards, 
Adil Mujeeb




-----Original Message-----
From: Blaisorblade [mailto:blaisorblade@yahoo.it]
Sent: Wednesday, January 12, 2005 11:02 PM
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Adil Mujeeb, Noida; user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-devel] uml_switch query


On Wednesday 12 January 2005 06:10, Adil  Mujeeb, Noida wrote:
> Hi,
> I have some questiosn related to uml switch

> 1. When we attach uml switch with tap device, what should be the command
> for it. I haev used:
>    a) uml_switch -unix /tmp/uml1 -tap tap10
>    But when we configure the device of UML, its not working:
>    uml_mconsole umid configure eth0=daemon,,unix,/tmp/uml1
>    Assign the IP address to eth device, but it is unable to ping the
> bridge.

Well, with two commas like you wrote the syntax seems indeed correct.

>    b) uml_switch -tap tap10
>    Now if we configure the device of UML, its working:
>    uml_mconsole umid configure eth0=daemon
>    Assign the IP address to eth device, it is able to ping the bridge.
Here
> default socket file is used /tmp/uml.ctl

> So why in first case it doesnt work?? Also if i use second approach, there
> may be problems. Like if i run one more switch attach with other tap
> device, then in that case default socket file is used which is already
> being used. This will cause any problems or not?? Same socket file can be
> attach to multiple uml_switches??
For what I remember, one uml_switch can manage one socket, and on that
socket 
you can attach as many UMLs as you like.
> 2. Is it possible to attach the uml switch with multiple tap devices??
Not necessary I think... the Uml_switch can use the tap device to forward
the 
traffic to the host network.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
