Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB0361045E@exch-03.noida.hcltech.com>
From: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [uml-devel] uml_switch query
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
Date: Wed, 12 Jan 2005 10:40:35 +0530
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Hi,
I have some questiosn related to uml switch

1. When we attach uml switch with tap device, what should be the command for
it. I haev used:
   a) uml_switch -unix /tmp/uml1 -tap tap10
   But when we configure the device of UML, its not working:
   uml_mconsole umid configure eth0=daemon,,unix,/tmp/uml1
   Assign the IP address to eth device, but it is unable to ping the bridge.

   b) uml_switch -tap tap10
   Now if we configure the device of UML, its working:
   uml_mconsole umid configure eth0=daemon
   Assign the IP address to eth device, it is able to ping the bridge. Here
default socket file is used /tmp/uml.ctl

So why in first case it doesnt work?? Also if i use second approach, there
may be problems. Like if i run one more switch attach with other tap device,
then in that case default socket file is used which is already being used.
This will cause any problems or not?? Same socket file can be attach to
multiple uml_switches??

2. Is it possible to attach the uml switch with multiple tap devices??
  
Thanks and Best Regards, 
Adil Mujeeb




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
