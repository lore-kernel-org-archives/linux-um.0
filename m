Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A45e6-0006pJ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 14:33:30 -0700
Received: from panoramix.vasoftware.com ([198.186.202.147] helo=externalmx.vasoftware.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A45e5-0000tc-9Z
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Sep 2003 14:33:29 -0700
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:1222 helo=esperi.demon.co.uk)
	by externalmx.vasoftware.com with esmtp (Exim 4.22 #1 (Debian))
	id 1A3dkF-00027V-Hu
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 28 Sep 2003 08:45:59 -0700
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm
 'not found'
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
	<20030919095020.294F93BCE4@home.petschge.de>
	<20030920173518.521B03BCE7@home.petschge.de>
	<Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org>
	<200309232016.h8NKGNaK003251@ccure.karaya.com>
	<Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org>
	<200309241619.h8OGJwaK006019@ccure.karaya.com>
From: Nix <nix@esperi.demon.co.uk>
In-Reply-To: <200309241619.h8OGJwaK006019@ccure.karaya.com> (Jeff Dike's
 message of "Wed, 24 Sep 2003 12:19:58 -0400")
Message-ID: <87fzig533b.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 28 Sep 2003 16:45:28 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Rod Moffitt <rodlist@rod.info>, user-mode-linux-devel@lists.sourceforge.net

On Wed, 24 Sep 2003, Jeff Dike stipulated:
> rodlist@rod.info said:
>> --w--w--w- == 222 
>> --x--x--x- == 111 
> 
> Err, right.  But I still have no idea what's happening.
> 
> If the file is there, it should definitely not fail to open.

Well, I was using hppfs and honeypot.pl with uml-2.4.22-4 (with skas),
and after a while the hppfs driver would seemingly cease forwarding
anything to honeypot.pl (I instrumented the honeypot and it was still
running, just not getting any requests).

Loads of messages were dumped on the console and into syslog like

hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1
hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1
hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1
hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1
hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1

Kernel panic: init_new_context_skas - new_mm failed, errno = -24

This is consistent with honeypot.pl ceasing to answer requests, but it
was still humming along. The requests just weren't getting forwarded to
it. (Plus, the init_new_context_skas is looking for /proc/mm on the
*host*, isn't it? Hm, maybe I'm barking up a gum tree here.  Anyway, I
haven't seen the init_new_context_skas error since I stopped using
hppfs. It's still built in, just not mounted anymore.)

-- 
`I treat debconf as a hostile imperialist agent.  "ALL CONFIGS YOURS
 NOW CONFIGS OURS ARE."' --- Stephen J. Turnbull


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
