Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <F47F4E3B83BE854AA0BCB998C6929516BCA1D6@tiki.fastmail.usf.edu>
From: "Gaspar, Alessio (USF Lakeland)" <alessio@lklnd.usf.edu>
Subject: [uml-devel] 2.6.12.4 host + 2.6.12w/ uml-2.6.12-bb12-skas0 hangs
	after "Starting periodic command scheduler: cron"
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
Date: Wed, 17 Aug 2005 13:36:33 -0400
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

Hi,
 
I've given a try to the following combination of host/guest kernels
yesterday: 

	Host = 2.6.12.4 on debian sarge
	Guest = 2.6.12.4 from kernel.org + 2.6.12-bb12-skas0 patch 
	Cmd line = ./linux con=null con0=fd:0,fd:1 
	FS = Debian-3.0r2.ext2

The system hangs after "Starting periodic command scheduler: cron."


Searching the linode irc logs and the devel mailing list didn't help so
far 
Other unsuccessful things I tried: 
- removing cron from /etc/init.d, then atd is the problem (same hang)
- removing atd from /etc/init.d (see a pattern here?) then the system
still hangs after "Starting Internet superserver: inetd" 

At this point, and before to go further, I'd like to check if: 
1. this host/guest kernel /patch combination is successful for anyone
2. if, like I suspect, the bug is coming from the file system 

Concerning the latter, trying other FS led to other bugs so I'd prefer
focusing on this one and fixing whatever this problem is...

Of course, any suggestion or workaround is more than welcomed :)

Alessio 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
