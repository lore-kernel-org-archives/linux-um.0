Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUrU4-0004NH-SE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 10:58:20 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CUrU4-0001Nc-6O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 10:58:20 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.58.0411181339460.4151@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] UID's no longer carried over hostfs?
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
Date: Thu, 18 Nov 2004 13:57:56 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>, Jeff Dike <jdike@addtoit.com>

Good day, all,

	On the host:

drwxr-xr-x    3 spamgate spamgate   184320 Nov 18 13:27 .
drwxr-xr-x    3 spamgate spamgate     4096 Jun  6 19:20 ..
drwxr-xr-x    4 spamgate spamgate  2170880 Nov 16 00:05 archives
-rw-rw-r--    1 spamgate spamgate    55975 Apr  4  2004 bogus-domain-info.txt
-rw-rw-r--    1 spamgate spamgate   209393 Nov 15  2003 confused_spammer.jpg
-rw-rw-r--    1 spamgate spamgate     3251 Nov 15  2003 confused_spammer.thumb.jpg

	fstab in the vm:
-bash-2.05b# cat /etc/fstab
/dev/ubd/0      /               ext2    defaults 1 1
/proc           /proc           proc    defaults
devpts          /dev/pts        devpts  mode=0622 0 0
/dev/ubd/1      none            swap    sw
/dev/ubd/2      /home           ext3    defaults 0 0
none            /shared         hostfs  defaults,/home/shared   0 0
none            /pub            hostfs  defaults,/home/pub      0 0
none            /mirrors        hostfs  defaults,/home/mirrors  0 0

	VM booted into 2.4.23:
-bash-2.05b# uname -a
Linux spamgate.stearns.org 2.4.23-pre8-5um #2 Sat Oct 25 18:07:50 EDT 2003 
i686 i686 i386 GNU/Linux
-bash-2.05b# ls -al /shared/spamgate/sa-blacklist-web/ | head
total 97160
drwxr-xr-x  3 processing processing  184320 Nov 18 13:27 .
drwxr-xr-x  3 processing processing    4096 Jun  6 19:20 ..
-rw-rw-r--  1 processing processing    3027 Feb  1  2004 README
-rw-rw-r--  1 processing processing    1865 Dec 14  2003 README.findingspammers.html
-rw-rw-r--  1 processing processing    2134 Apr 21  2004 README.howtotest.html
-rw-rw-r--  1 processing processing    7497 Apr 24  2004 README.howtouse.html
-rw-rw-r--  1 processing processing    1400 Feb  1  2004 README.policy
-rw-rw-r--  1 processing processing    3315 Apr 24  2004 README.submissions.html
drwxr-xr-x  4 processing processing 2170880 Nov 16 00:05 archives

	VM booted into 2.4.27:
-bash-2.05b# uname -a
Linux spamgate.stearns.org 2.4.27-1um #1 Fri Nov 12 11:53:23 EST 2004 i686 i686 i386 GNU/Linux

drwxr-xr-x  3 root root  184320 Nov 15 23:16 .
drwxr-xr-x  3 root root    4096 Jun  6 19:20 ..
-rw-rw-r--  5 root root    3027 Feb  1  2004 README
-rw-rw-r--  5 root root    1865 Dec 14  2003 README.findingspammers.html
-rw-rw-r--  5 root root    2134 Apr 21  2004 README.howtotest.html
-rw-rw-r--  5 root root    7497 Apr 24  2004 README.howtouse.html
-rw-rw-r--  5 root root    1400 Feb  1  2004 README.policy
-rw-rw-r--  5 root root    3315 Apr 24  2004 README.submissions.html
drwxr-xr-x  4 root root 2170880 Nov 16 00:05 archives
-rw-rw-r--  1 root root   55975 Apr  4  2004 bogus-domain-info.txt
-rw-rw-r--  1 root root  209393 Nov 15  2003 confused_spammer.jpg
-rw-rw-r--  1 root root    3251 Nov 15  2003 confused_spammer.thumb.jpg

	I was used to the behavior that UID's were carried by hostfs 
verbatim, and this allowed the "processing" user or root to write out to 
the host.  With 2.4.27 decreeing that all files are owned by root, I can't 
do this any more.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Evil, I think, is the absence of empathy."
        -- Psychiatrist in the movie "Nuremburg"
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
