Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYaoa-0008Uj-UD
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 16:54:24 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AYaoZ-00066i-1B
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 16:54:23 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] UML on Alpha
Message-ID: <20031223011046.GA16757@ccure.user-mode-linux.org>
References: <20031220052032.GC1152@erdos.home> <20031220173249.GC10692@ccure.user-mode-linux.org> <20031222041951.GB1023@erdos.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222041951.GB1023@erdos.home>
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
Date: Mon, 22 Dec 2003 20:10:46 -0500
To: user-mode-linux-devel@lists.sourceforge.net, Cameron Patrick <cameron@patrick.wattle.id.au>

On Mon, Dec 22, 2003 at 12:19:51PM +0800, Cameron Patrick wrote:
> Yeah, but that's fpstate, not fpregs.  

Oops, nevermind...

> Okay.  It doesn't seem to be there in 2.4.x, but I'll have a look at 2.6
> some time and see if that makes this problem disappear.

It's not there either.  I think for now, ifdef those things on something like 
CONFIG_64BIT_UML, and set that in your config.in.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
