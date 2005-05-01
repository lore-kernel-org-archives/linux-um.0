Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSE1Q-0002SP-MY	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 05:58:08 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DSE1P-0003yp-7R	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 05:58:08 -0700
Message-ID: <52841.80.203.9.198.1114952281.squirrel@80.203.9.198>
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] getdents problem upon SIGALRM
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
Date: Sun, 1 May 2005 14:58:01 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net


Just a quick question. Have anybody seen hostfs randomly failing to list
files when doing ls on samba-filesystems on the host, or other
filesystems?


Just wondering if I'm alone in the world being bother by this kernel-bug:
http://bugzilla.kernel.org/show_bug.cgi?id=4497



Stian Skjelstad aka mw|


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
