Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJ6aU-0003rX-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 23:35:50 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AJ6aT-00086I-GH
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 23:35:49 -0800
Subject: Re: [uml-devel] redefinition of `struct ptrace_faultinfo' with
 uml-2.4.22-4 + skas3
References: <87brtkuwm8.fsf@amaterasu.srvr.nix>
	<200311100239.hAA2dcxD013077@ccure.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200311100239.hAA2dcxD013077@ccure.user-mode-linux.org> (Jeff
 Dike's message of "Sun, 09 Nov 2003 21:39:38 -0500")
Message-ID: <874qxciskx.fsf@amaterasu.srvr.nix>
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
Date: Mon, 10 Nov 2003 07:35:42 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, 09 Nov 2003, Jeff Dike yowled:
> nix@esperi.demon.co.uk said:
>> This has come up before on the lists (first report in late 2002), and
>> nobody's ever come up with preprocessed source. Until now. 
> 
> This is nasty because the UML tree has to assume that the i386 tree doesn't
> have ptrace_faultinfo in it.  Since you applied the host skas patch to your
> UML tree, that assumption is broken.

OK. Who knows, maybe this caused some of my bizarre crashes (grasping in
the dark here)...

> So, for now, I would say that you shouldn't try to build both host kernels and
> UML kernels from a tree which has that patch in it.

OK. I should go up to 2.4.22-5 anyway; this gives me an excuse. :)

(I reverted every other patch, but considered that *of course* skas
wouldn't clash with other patches involved in the same project. Oops.)

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
