Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMBBq-0000jh-Ep for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 13:11:38 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CMBBo-0006V3-HO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 13:11:38 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 07/10] uml: kbuild - add even more cleaning
References: <20041012001759.317908695@zion.localdomain>
	<20041025084308.GA19935@taniwha.stupidest.org>
In-Reply-To: <20041025084308.GA19935@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410252211.22562.blaisorblade_spam@yahoo.it>
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
Date: Mon, 25 Oct 2004 22:11:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Wedgwood <cw@f00f.org>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Monday 25 October 2004 10:43, Chris Wedgwood wrote:
> On Tue, Oct 12, 2004 at 02:17:59AM +0200, blaisorblade_spam@yahoo.it wrote:
> >  MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
> > -	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
> > +	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
>
> these sorts of rules don't work when doing "make O=build ARCH=um ..."
Yes, they do as much as they can.  Kbuild cd's to the objtree before doing 
anything. Specifying $(objtree) is not needed. Specifying $(obj) probably 
does not even work in the ARCH Makefile.

That said, O=<whatever> is highly broken; it seems that Gerd Knorr was able to 
build the tree with O=, but actually some files are still created in the 
source tree, while they should not. This is a problem and would require 
various changes.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
