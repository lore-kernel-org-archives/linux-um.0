Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdZBL-0003UZ-EB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 10:10:27 -0800
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AdZBK-0001M6-U6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 10:10:27 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20040105181018.GU28393@alcor.net>
References: <20031222090856.GD9354@alcor.net>
	<Pine.LNX.4.44.0401051150500.1263-100000@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401051150500.1263-100000@gradall.private.brainfood.com>
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
Date: Mon, 5 Jan 2004 10:10:18 -0800
To: Adam Heath <adam@doogie.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org, debian-glibc@lists.debian.org

On Mon, Jan 05, 2004 at 11:51:24AM -0600, Adam Heath wrote:

> On Mon, 22 Dec 2003, Matt Zimmerman wrote:
> 
> > user-mode-linux builds with gcc-2.95 explicitly, which I don't think has had
> > substantial changes this year.
> >
> > I should note that UML is statically linked as well.
> 
> try a dynamic skas-only build(on unstable), running on unstable, then woody.
> 
> If this works, then it's probably a bug in libc itself.

Building with gcc-3.3 fixed the problem.

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
