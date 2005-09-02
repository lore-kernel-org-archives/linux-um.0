Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBARK-0003Cl-Io	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 05:14:38 -0700
Received: from [81.2.110.250] (helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EBARI-0003f7-S3
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 05:14:38 -0700
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200509012216.j81MGnSH011518@ccure.user-mode-linux.org>
References: <200509012216.j81MGnSH011518@ccure.user-mode-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1125664715.30867.4.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [uml-devel] Re: [PATCH 1/12] UML - tty fix
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
Date: Fri, 02 Sep 2005 13:38:35 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Iau, 2005-09-01 at 18:16 -0400, Jeff Dike wrote:
> This fixes a build breakage introduced by Alan's tty cleanups.  This should
> be tied to that patch if possible.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
> 
> Index: linux-2.6.13-mm1/arch/um/drivers/chan_kern.c
> ===================================================================

Acked-by: Alan Cox <alan@redhat.com>

(and applied to my tty tree for future diff generation)



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
