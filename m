Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BX2oS-0002KB-3w for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jun 2004 11:56:08 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BX2oP-0005Ao-AS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Jun 2004 11:56:05 -0700
Message-ID: <114f01c44bf8$f10b2ab0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.33.0406061934430.2205-100000@fuji.prized>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Question about uml_switch
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
Date: Sun, 6 Jun 2004 21:03:23 +0200
To: henrique <henrique@moreira.dnsalias.net>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

> At least the version I am using (2.4.24-1um #3),
> assigns hwaddr (MAC-address) uniquely with a given static ip.

mhhh - but the bridging howto at
http://edeca.net/articles/bridging/questions.html
tells:

Q:
Why can multiple UMLs on a bridge talk to the host but not each other?
A:
By default, every UML instance uses the same MAC address so ethernet can't 
distinguish the two hosts.  You need to assign each UML a unique MAC address 
by specifying it as part of the eth0 argument, like so: "eth0=tuntap,tap1,
FE:FD:00:00:00:01".

and i can acknowledge this, as far as i remember. i always specify the mac
adress on the commandline - being "safe" this way.

so - what is right ?

is there differnt neworking code in different uml versions ?

roland


----- Original Message ----- 
From: "henrique" <henrique@fuji.moreira.dnsalias.net>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-user@lists.sourceforge.net>
Sent: Sunday, June 06, 2004 8:42 PM
Subject: Re: [uml-user] Question about uml_switch


> > Alex, 
> > you hit a little "uml annoyance" - uml itself doesn`t assign a unique
> > MAC-Address to itself at startup. (afaik)
> 
> Hello Roland,
> 
> At least the version I am using (2.4.24-1um #3),
> assigns hwaddr (MAC-address) uniquely with a given static ip.
> 
> command-line example: eth0=tuntap,tap0
> I use the static ip on UML: 192.168.0.147,
> and the hwaddr is FE:FD:XX:XX:XX:93 (93 hexa is 147 decimal).
> 
> XX:XX:XX are of course the hexa values for 192.168.0.
> 
> On the UML eth0 configurator I use is a plain 'ifconfig'...
> 
> 
> Regards,
> Henrique
> 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
