Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkirB-0007s0-Ib for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 09:13:21 -0700
Received: from pasmtpa.tele.dk ([80.160.77.114])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ikir9-0003UG-3y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 09:13:21 -0700
Date: Wed, 24 Oct 2007 18:14:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20071024161448.GA3166@uranus.ravnborg.org>
References: <200710111754.46854.rob@landley.net>
	<20071024152240.GA7733@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071024152240.GA7733@c2.user-mode-linux.org>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>, sparclinux@vger.kernel.org
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>

Hi Jeff.

On Wed, Oct 24, 2007 at 11:22:40AM -0400, Jeff Dike wrote:
> On Thu, Oct 11, 2007 at 05:54:46PM -0500, Rob Landley wrote:
> > Guess what?  I still need this patch to build the final 2.6.23, months later.
> > 
> > I know it may not be the right fix, but the build breaks for me without this 
> > patch. The .config that breaks is attached.  ARCH=um.
> 
> Can I get a Signed-off-by: on that?
> 
> It's not the right fix - the base of the problem is in swap.h, which
> has this comment: 
> 	/* only sparc can not include linux/pagemap.h in this file
> 	 * so leave page_cache_release and release_pages undeclared... */
> 
> I poked around a bit for a sparc cross-toolchain, didn't find one, so
> I couldn't see what exactly the problem was.
> 
> So, I'll take this fix.

Dan Kegel's crosstool builds sparc just fine.
And for sparc issues I recommend cc:ing the sparc ML.

[Original mail (with patch) is here: http://lkml.org/lkml/2007/10/11/288]

	Sam

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
