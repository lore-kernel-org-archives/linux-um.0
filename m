Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJf00-0005zq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 11 Nov 2003 12:20:28 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AJezz-0002CF-Di
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 11 Nov 2003 12:20:27 -0800
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm
 'not found'
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
	<20030919095020.294F93BCE4@home.petschge.de>
	<20030920173518.521B03BCE7@home.petschge.de>
	<Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org>
	<200309232016.h8NKGNaK003251@ccure.karaya.com>
	<Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org>
	<200309241619.h8OGJwaK006019@ccure.karaya.com>
	<87fzig533b.fsf@amaterasu.srvr.nix>
	<200311100239.hAA2daxD013066@ccure.user-mode-linux.org>
	<878ymoiso6.fsf@amaterasu.srvr.nix>
	<200311112013.hABKDPIU002749@ccure.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200311112013.hABKDPIU002749@ccure.user-mode-linux.org> (Jeff
 Dike's message of "Tue, 11 Nov 2003 15:13:25 -0500")
Message-ID: <87k766d5ds.fsf@amaterasu.srvr.nix>
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
Date: Tue, 11 Nov 2003 20:20:15 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 11 Nov 2003, Jeff Dike yowled:
> nix@esperi.org.uk said:
>> The crash seems to happen when I'm sshed in from the outside world
>> doing things that involve lots of tty activity: I wonder if the tty
>> logging may be at fault?
> 
> I just checked the code.  It seems to close everything that it opens, so
> that appears not to be the problem.

I'll hack uml to freeze rather than crashing so I can try to gdb it next
time this happens. (If it happens at all with -5...)

-- 
`Me, I want exploding spaceships and pulverized worlds and clashes of
 billion-year-old empires *and* competently written sentences.'
                                                    --- Matt Austern


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
