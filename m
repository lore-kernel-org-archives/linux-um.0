Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IeuCp-0006aa-El for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:07:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IeuCo-0001Oy-Tw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:07:39 -0700
Date: Mon, 8 Oct 2007 11:07:24 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071008150724.GE5279@c2.user-mode-linux.org>
References: <200710041438.57150.rrs@researchut.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200710041438.57150.rrs@researchut.com>
Subject: Re: [uml-devel] SKAS as a module
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
To: Ritesh Raj Sarraf <rrs@researchut.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 04, 2007 at 02:38:51PM +0530, Ritesh Raj Sarraf wrote:
> Performance of UML improves a lot when used with SKAS. But SKAS is not in the 
> standard kernels shipped by most distributions. Probably because it isn't 
> included upstream.

Probably, although it is in SuSE kernels.

> Is there a possibility of turning the patch to be used as a kernel module ?
> If yes, I guess distributors will be able to ship it separately. And users 
> will be able to use it with their standard kernels shipped by the 
> distributors.

It has been done, a long time ago.  I think the major problem is that
there are interfaces that the skas module would need to call that
aren't exported to modules.

This being the case, there would need to be a patch to the kernel to
export those interfaces as well as the actual module.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
