Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKcHl-0005K7-GF	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 06:47:49 -0700
Received: from qproxy.gmail.com ([72.14.204.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKcHl-0001bw-6G
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 06:47:49 -0700
Received: by qproxy.gmail.com with SMTP id f10so669006qba
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Sep 2005 06:47:42 -0700 (PDT)
Message-ID: <3524bf1f05092806477e590930@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
In-Reply-To: <200509281359.48449.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	 <20050927172812.GA28528@ccure.user-mode-linux.org>
	 <200509281359.48449.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 09:47:41 -0400
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Thank you for your reply, but still have one more.

(i think i forgot to reply to the mailing list with the previous
email, so, i'm attaching the text)

On 9/28/05, Jeff Dike <jdike@addtoit.com> wrote:
> On Tue, Sep 27, 2005 at 08:56:51PM -0400, Young Koh wrote:
> > 1) if the address is fine, shouldn't the access that causes a segfault
> > be regarded as a page fault? that is, shouldn't it be handled by UML
> > kernel and UML proceeds normally instead of returning an error to the
> > application? (because the app gave the proper address)
>
> No.
>
> It's akin to a piece of memory all of a sudden going bad.  You allocated the
> memory and thought you could use it, but when you try, it turns out not
> to be there.

yes, i think memory can go bad if 1) it cannot be allocated because of
filesystem full or similar reasons as Jeff described, or 2) it was
allocated once but could have been swapped.

in case of 1) it should be more like kernel panic rather than just a
system call error, i think? because kernel cannot allocate any more
memory, which kernel is supposed to use.

in case of 2) this is a real fault, so, the seg fault handler of UML
kernel is supposed to load the swapped page and UML kernel proceeds
normally? (as Blaisorblade described in the other mail, by calling
handle_page_fault()?)

Thank you,

-Young

>
> > 2) i thought that the file used for UML memory is created when a UML
> > process is initialized.
> > then, the memory file is not created for the fixed size at first, but
> > it changes the size according to the UML memory usage?
>
> It's not fully allocated.  It starts off sparse and gets allocated on
> the host as the guest's memory usage increases.
>
> > 3) is it the only case sigsetjmp() protected from?
>
> I believe so, but am not positive.
>
>                                 Jeff
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
