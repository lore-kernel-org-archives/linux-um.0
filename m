Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ke8tL-0004mW-Ji for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 06:40:55 -0700
Received: from jaguar.ecp.fr ([138.195.33.9])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ke8tK-00026i-7L
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Sep 2008 06:40:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by jaguar.ecp.fr (Postfix) with ESMTP id 06B326802C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 15:40:45 +0200 (CEST)
Received: from jaguar.ecp.fr ([127.0.0.1])
	by localhost (jaguar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05290-09
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 15:40:44 +0200 (CEST)
Received: from [138.195.30.9] (kheops.system.ecp.fr [138.195.30.9])
	by jaguar.ecp.fr (Postfix) with ESMTP id E762C68008
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 12 Sep 2008 15:40:44 +0200 (CEST)
Message-ID: <48CA7158.5080500@ecp.fr>
Date: Fri, 12 Sep 2008 15:40:40 +0200
From: Nicolas Boullis <nicolas.boullis@ecp.fr>
MIME-Version: 1.0
Subject: [uml-devel] parallel I/O
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I've been using uml on production servers for months, and have been
quite happy with it, except for I/O performance.

I was using the user-mode-linux package from Debian Etch, based on
2.6.18, and compiled with CONFIG_BLK_DEV_UBD_SYNC. Disabling this option
of course helps performance, but I feel that it's somewhat unsafe if the
host crashes... Moreover, I don't think it helps read performance.

As far as I can see, if one wants both safety and performance, the I/O
must not be serialized. So I decided to give it a try.

The first step was to run a per-device I/O thread. This improves
slightly the performance with several UBD devices: I/O on one device do
not block I/O on another device. Moreover, that helps to implement
parallelized I/O.

Then I managed to run several parallel threads per device. As far as I
am concernced, that much improves the performance. But currently, my
code is more a dirty proof-of-concept than a clean patch.

Would you be interested by my work?


Cheers,

Nicolas Boullis
=C9cole Centrale Paris

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
