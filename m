Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200309032033.h83KXM6b013752@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml_utilities_20030903
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 03 Sep 2003 16:33:22 -0400
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

The main addition in this update is COW V3 support in uml_moo.  uml_mkcow
is also here, although I wouldn't get too attached to it since I'm thinking
about moving it into uml_moo and making that the Swiss Army knife of COW file
manipulation.

There are a bunch of smaller changes in uml_switch, uml_mconsole, and the
honeypot utilities.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
