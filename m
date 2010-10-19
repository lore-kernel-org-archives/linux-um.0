Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <stian@nixia.no>) id 1P8B32-0007MX-Fy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2010 12:12:08 +0000
Received: from mail42.e.nsc.no ([193.213.115.42])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8B30-0001YS-Kf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2010 12:12:08 +0000
From: "Stian Skjelstad" <stian@nixia.no>
References: <4CB821EE.2010208@websuche.de> <4CBD79B8.2000803@websuche.de>
In-Reply-To: <4CBD79B8.2000803@websuche.de>
Date: Tue, 19 Oct 2010 13:24:18 +0200
Message-ID: <000901cb6f80$2d7b3f60$8871be20$@no>
MIME-Version: 1.0
Content-Language: no
Subject: Re: [uml-devel] general protection failures
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: 'Felix Antonius Wilhelm Ostmann' <ostmann@websuche.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

Just some few things to check. How is the memory pressure? What resources does the UML instances use (network, hostfs, cow). Could it be related to a network-device not being able initialize?


Stian Skjelstad


> no hints? :-/
>
>Am 15.10.2010 11:42, schrieb Felix Antonius Wilhelm Ostmann:
>> We use UML since 4 years on one host (P4). Now we build another UML-Host
>> on a Xeon and all was fine. A week ago we startet the third guest at the
>> Xeon Host and after some time the guest was killed from the host (see
>> the log at the end). It is allways the third startet guest. We stopped
>> all guest and startet in different order and the last (third) startet
>> guest get the general protection error. Thanks for any help!



------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

