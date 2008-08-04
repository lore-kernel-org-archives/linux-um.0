Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPzMP-0004Z1-Kw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 05:40:25 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KPzMO-00064L-6p for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 05:40:25 -0700
Received: from [192.168.130.27] (lnxtleo01004.meduna.lan [192.168.130.27])
	by meduna.org (Postfix) with ESMTP id B94E99C434
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  4 Aug 2008 14:48:08 +0200 (CEST)
Message-ID: <4896F8A1.6020203@meduna.org>
Date: Mon, 04 Aug 2008 14:40:01 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
Subject: [uml-devel] /dev/random problems _not_ solved in 2.6.26
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

this is just to let you know that the /dev/random problems
are still not solved in the 2.6.26 version. A small dictionary
attack on sshd (in my case 260 tries over 12 minutes)
are able to produce

auth.log.0:Aug  3 05:30:35 dirk sshd[1825]: fatal: Couldn't obtain random bytes (error 
604389476)

and the sshd dies (followed by apache on the first subsequent
SSL request and so on).


Unfortunately I can't help you in tracing the uml process
or trying patches - this is a virtual server at my provider
and I don't have any access there. I could try to get
the .config file.


# uname -a
Linux dirk 2.6.26 #1 Wed Jul 30 10:56:10 CEST 2008 i686 GNU/Linux

# cat /proc/cpuinfo
processor       : 0
vendor_id       : User Mode Linux
model name      : UML
mode            : skas
host            : Linux seldon-base 2.6.23.17 #2 SMP Sat Jun 21 15:04:22 CEST 2008 i686
bogomips        : 4771.02

# cat /proc/sys/kernel/random/entropy_avail
293

After exhausting the entropy with

   cat /dev/random | od -cx

the entropy only slooowly gets up, one byte per several
seconds or so with me typing in the ssh console...


Regards
-- 
                                 Stano


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
