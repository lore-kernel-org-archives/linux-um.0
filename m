Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3fRC-00013T-Eq	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 12:43:30 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E3fRC-0002B3-30
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 12:43:30 -0700
From: Russell King <rmk+lkml@arm.linux.org.uk>
Message-ID: <20050812204315.B21152@flint.arm.linux.org.uk>
References: <20050812182123.C896324E7DD@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812182123.C896324E7DD@zion.home.lan>;
	from blaisorblade@yahoo.it on Fri, Aug 12, 2005 at 08:21:23PM +0200
Subject: [uml-devel] Re: [patch 11/39] remap_file_pages protection support:
	add MAP_NOINHERIT flag
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
Date: Fri, 12 Aug 2005 20:43:15 +0100
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 12, 2005 at 08:21:23PM +0200, blaisorblade@yahoo.it wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Add the MAP_NOINHERIT flag to arch headers, for use with remap-file-pages.

Does this mean ARM will break when these patches are merged?

> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  linux-2.6.git-paolo/include/asm-i386/mman.h   |    1 +
>  linux-2.6.git-paolo/include/asm-ia64/mman.h   |    1 +
>  linux-2.6.git-paolo/include/asm-ppc/mman.h    |    1 +
>  linux-2.6.git-paolo/include/asm-ppc64/mman.h  |    1 +
>  linux-2.6.git-paolo/include/asm-s390/mman.h   |    1 +
>  linux-2.6.git-paolo/include/asm-x86_64/mman.h |    1 +
>  6 files changed, 6 insertions(+)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
