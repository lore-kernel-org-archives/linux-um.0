Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CM0Rv-0004sf-IN for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 01:43:31 -0700
Received: from pimout1-ext.prodigy.net ([207.115.63.77])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CM0Ru-00036q-OK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Oct 2004 01:43:31 -0700
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041025084308.GA19935@taniwha.stupidest.org>
References: <20041012001759.317908695@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012001759.317908695@zion.localdomain>
Subject: [uml-devel] Re: [patch 07/10] uml: kbuild - add even more cleaning
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
Date: Mon, 25 Oct 2004 01:43:08 -0700
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 12, 2004 at 02:17:59AM +0200, blaisorblade_spam@yahoo.it wrote:

>  MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
> -	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
> +	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os

these sorts of rules don't work when doing "make O=build ARCH=um ..."


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
