Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdmB7-0002ys-5e for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 00:03:05 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AdmB6-0002OC-Ol for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Jan 2004 00:03:04 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: Resolution (Re: [uml-devel] 2.4.22-[67] problems)
Message-ID: <20040106080258.GT28393@alcor.net>
References: <20031220171450.GB10692@ccure.user-mode-linux.org>
	<20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<3FFA66B3.501@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFA66B3.501@vgertech.com>
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
Date: Tue, 6 Jan 2004 00:02:58 -0800
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

On Tue, Jan 06, 2004 at 07:41:39AM +0000, Nuno Silva wrote:

> Jeff Dike wrote:
> >mdz@debian.org said:
> >Is it your opinion that there's no problem in UML itself?  Having a field
> >in the sigcontext getting magically munged is somewhat worrying.  I'd be 
> >happier knowing what exactly was happening so I can be sure this wasn't
> >exposing some subtle UML bug.
> >
> 
> I've been doing some tests and I'd say that the problem is something 
> regarding the NPTL+TLS+__thread features of recent libc6 (2.3.2 and 
> 2.3.3cvs)... But I'm clueless about the fix :-)

I suspect that the problem lies in this direction, because it's the only
relevant news that I've heard from glibc in recent months, but I wouldn't
expect NPTL to relate directly because I'm running on 2.4 (as are several
others who have seen the problem).

This is the issue where i386 support was dropped and i486-specific
instructions used, right?

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
