Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNYoA-0003Ik-Fs for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 08:36:54 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CNYo9-0002Fi-2r for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 08:36:54 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Unexported symbol in 2.6.9?
References: <lars-CA00F4.10070129102004@sea.gmane.org>
In-Reply-To: <lars-CA00F4.10070129102004@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291737.58697.blaisorblade_spam@yahoo.it>
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
Date: Fri, 29 Oct 2004 17:37:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lars Kellogg-Stedman <lars@oddbit.com>

On Friday 29 October 2004 16:07, Lars Kellogg-Stedman wrote:
> I just built a 2.6.9 UML kernel, and ended up with an error in the NTFS
> filesystem module.  The symbol "end_iomem" was undefined.  This appears
> to be defined in arch/um/um_arch.c, and adding EXPORT_SYMBOL(end_iomem)
> makes the error go away.

> Is this the correct solution?
Yes, absolutely. I'll include this soon.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
