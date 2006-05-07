Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fckt9-0007sl-BP for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2006 08:09:39 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fckt9-0004cA-Ak for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2006 08:09:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fckt8-0007IU-Pq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2006 08:09:39 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] do_uml_initcalls
Message-ID: <20060507140956.GA3108@ccure.user-mode-linux.org>
References: <20060507125412.GA16519@Starbuck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060507125412.GA16519@Starbuck>
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
Date: Sun, 7 May 2006 10:09:56 -0400
To: tyler@agat.net, user-mode-linux-devel@lists.sourceforge.net

On Sun, May 07, 2006 at 02:54:12PM +0200, user-mode-linux-devel-admin@lists.sourceforge.net wrote:
> First, there's a ';' at the end of line 6 : typo error I guess.

Yup, nice spotting.

> But my point is : this function is unreadable !

It could hardly get any simpler.

> It does simply call all the functions in the ".initcall"
> section.
> 
> Wouldn't it be better to call all the functions explicitely ?

No, adding an initcall now is a matter of writing it and declaring it
as an initcall, which adds one contiguous piece of code to one file.
Adding an explicit call means 
	writing the function
	declaring it in a header so that do_uml_initcalls will see it
	including that header in the file that implements the function
to ensure that the implementation and declaration are the same
	adding the call to do_uml_initcalls

Aside from the extra code that requires, the calls and the
declarations would turn into a hot spot that a lot of patches change,
and hot spots are a pain when it comes to reordering patches.

> Btw, what is the difference between the initcall and init sections ?

init sections are code which are executed only during initialization
and which can be thrown out once the kernel is booted.  initcall makes
the function be automatically called, init just makes it be thrown out
- you have to arrange to call it yourself.

> Because I was thinking of another problem : the modules. If some modules
> are compiled and that the init_modules functions are put in the initcall
> section, then all the modules will be loaded.

I don't think so.  The init functions can only be called if they are
in the kernel's initcall section, and then they aren't modules any
more.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
