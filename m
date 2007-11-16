Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Isorv-0004pk-3t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Nov 2007 16:15:45 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Isort-0000yG-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Nov 2007 16:15:34 -0800
Date: Thu, 15 Nov 2007 16:15:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20071115161521.21c4b7f5.akpm@linux-foundation.org>
In-Reply-To: <20071114192049.GA9083@c2.user-mode-linux.org>
References: <20071114192049.GA9083@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/4] UML - Remove unused variables in the
	context switcher
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
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, magotari@gmail.com

On Wed, 14 Nov 2007 14:20:49 -0500
Jeff Dike <jdike@addtoit.com> wrote:

> This patch removes a variable which was not used in two functions.
> Yet another code cleanup, nothing really significant.
> 
> Please note that I could not test this on x86_64. I don't have the
> hardware for it.
> 
> [ jdike - Bits of tidying around the affected code.  Also, it's fine on
> x86_64 ]
> 
> Signed-off-by: Karol Swietlicki <magotari@gmail.com>
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>

I assumed from the above that Karol was the author of this patch.  Please
let me know if that was wrong.

We communicate authorship by putting a From: line at the very start of the
changelog.  If that line is not present then we use the From: from the
email headers.

Thanks.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
