Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <403FBD07.9000500@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] BUG REPORT -- getting "registered fd 47 twice"
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
Date: Fri, 27 Feb 2004 16:56:23 -0500
To: User-mode-linux-devel@lists.sourceforge.net, User-mode-linux-user@lists.sourceforge.net

Got a bug report for you guys, please CC me since I'm not subscribed...

I've got a 2.4.24 kernel with the latest uml patch, running on a 2.4.19 
host.  UML is running just plain, no skas or /dev/anon.  I'm using a 
whole bunch of boot args, enough that I had to expand the array in 
init/main.c.

Anyways, when I boot it goes through the startup fine, but when it gives 
the login prompt I see this:


DSC-0-0-0 login: Registering fd 47 twice
Irqs : 3, 3
Ids : 0xa0261138, 0xa0261138
Registering fd 47 twice
Irqs : 3, 3
Ids : 0xa0261138, 0xa0261138



The irq 3 corresponds to CONSOLE_IRQ.  When I try and log in it spits 
out the following, once per character I type:


find_irq_by_fd doesn't have descriptor 47


Then it starts spewing out the following message until I kill the process:


Failed to forward -1439843404 to pid 17758, err = 9


Where 17758 is the pid for bash.  With gdb I set a breakpoint in 
line_setup_irq, and ran a backtrace just before the first error message 
above.  This is what I got:


Breakpoint 5, line_setup_irq (fd=-1608117768, input=-1608117768,
     output=-1347667284, data=0xa0261200) at line.c:199
199     {
(gdb) bt
#0  line_setup_irq (fd=-1608117768, input=-1608117768, output=-1347667284,
     data=0xa0261200) at line.c:199
#1  0xa0126efe in enable_chan (chans=0xa0261200, data=0xa02611f8)
     at chan_kern.c:164
#2  0xa01284af in line_open (lines=0xa0261200, tty=0xaa75c000, opts=0x2f)
     at line.c:255
#3  0xa0126971 in open_console (tty=0x2f) at stdio_console.c:135
#4  0xa00efb07 in tty_open (inode=0xaa60d9e0, filp=0xaa380e20) at 
tty_io.c:1437
(gdb)
bre


So, somehow the generic tty_open stuff is giving strange behaviour.  Any 
ideas what's going on?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
