Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaFT6-00035P-8S for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 10:12:24 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FaFT6-0003BH-5X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 10:12:24 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FaFT2-00075X-Hv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Apr 2006 10:12:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
	<20060430141614.9060.3376.stgit@zion.home.lan>
In-Reply-To: <20060430141614.9060.3376.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604301732.59645.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 3/7] uml: make copy_*_user atomic
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
Date: Sun, 30 Apr 2006 17:32:56 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sunday 30 April 2006 16:16, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
>
> Make __copy_*_user_inatomic really atomic to avoid "Sleeping function
> called in atomic context" warnings, especially from futex code.
>
> This is made by adding another kmap_atomic slot and making copy_*_user_skas
> use kmap_atomic; also copy_*_user() becomes atomic, but that's true and is
> not a problem for i386 (and we can always add might_sleep there as done
> elsewhere). For TT mode kmap is not used, so there's no need for this.
>
> I've had to use another slot since both KM_USER0 and KM_USER1 are used
> elsewhere and could cause conflicts. Till now we reused the kmap_atomic
> slot list from the subarch, but that's not needed as that list must contain
> the common ones (used by generic code) + the ones used in architecture
> specific code (and Uml till now used none); so I've taken the i386 one
> after comparing it with ones from other archs, and added KM_UML_USERCOPY.

> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Ok, I didn't want indeed to send this one _for merging_, even if I consider it 
correct and it indeed fixes the warnings; additionally, since HIGHMEM support 
is not very used (it's slow and less tested), there shouldn't be problems 
anyway.

Please keep it in -mm however, it should be ok and there it could get more 
exposure - and this is about interaction with the core kernel so it could get 
valid review from people outside UML.

Jeff, give a look to this one please. You need CONFIG_DEBUG_SPINLOCK_SLEEP and 
a futex user (for instance starting threaded apache inside the guest) to 
trigger the warnings.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
