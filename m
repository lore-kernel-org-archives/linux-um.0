Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <3FEAE023.6040908@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] ubd=mmap problem
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 25 Dec 2003 14:03:31 +0100
To: UML devel list <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net

Hi there,

i started uml with udb=mmap, the box runs fine but today i
noticed that the box was terminated after a nightly cron
run inside the uml. While trying to figure out what the
problem was, i noticed that the uml can't reboot anymore
cause it hangs in an endless loop when unmounting the devices.
all i saw was:
map : /proc/mm map failed, err = 9
map : /proc/mm map failed, err = 9
map : /proc/mm map failed, err = 9
map : /proc/mm map failed, err = 9
map : /proc/mm map failed, err = 9
map : /proc/mm map failed, err = 9

this was with 2.4.23 and latest uml 2.4.22 patch. So i thought
its an problem with the patches and builded a fres 2.4.23 with
the latest -1 patch. But the problem is still there. When i
remove the udb=mmap from my startup line, uml works and reboots
like expected. Anyone had that too or can tell me what the
Problem is? ;) The host is running 2.4.22 with skas patch.

Regards,
Sven



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
