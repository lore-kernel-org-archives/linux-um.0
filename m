Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ComJN-00064u-K4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 09:29:37 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1ComJL-00072l-RE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 09:29:37 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] uml_switch query
References: <267988DEACEC5A4D86D5FCD780313FBB0361045E@exch-03.noida.hcltech.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB0361045E@exch-03.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121831.48720.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 18:31:48 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Adil Mujeeb, Noida" <adilm@hcltech.com>, user-mode-linux-user@lists.sourceforge.net

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
>    Assign the IP address to eth device, it is able to ping the bridge. Here
> default socket file is used /tmp/uml.ctl

> So why in first case it doesnt work?? Also if i use second approach, there
> may be problems. Like if i run one more switch attach with other tap
> device, then in that case default socket file is used which is already
> being used. This will cause any problems or not?? Same socket file can be
> attach to multiple uml_switches??
For what I remember, one uml_switch can manage one socket, and on that socket 
you can attach as many UMLs as you like.
> 2. Is it possible to attach the uml switch with multiple tap devices??
Not necessary I think... the Uml_switch can use the tap device to forward the 
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
