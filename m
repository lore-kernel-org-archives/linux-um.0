Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERaJA-0007vU-DR	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 12:06:04 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ERaJ9-0002fI-Kz
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Oct 2005 12:06:04 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Starting uml with the debugger
In-Reply-To: <229e70f20510171123o21d4bda8t3c03a5c229e85ad2@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0510172057120.23546@filer.marasystems.com>
References: <229e70f20510171009x103fe854ncb91021c3ce0e31e@mail.gmail.com> 
 <20051017175328.GA8015@localhost.localdomain>
 <229e70f20510171123o21d4bda8t3c03a5c229e85ad2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 17 Oct 2005 21:05:44 +0200 (CEST)
To: Etay Meiri <etay.meiri@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 17 Oct 2005, Etay Meiri wrote:

>> If this thing is new enough to have skas0, then just disable 
>> CONFIG_MODE_TT and gdb it normally.
>
>
> Will it still run if my host kernel is not skas enabled?

Yes.

SKAS0 is implementing memory management usign the same principles as SKAS, 
but without support from the host kernel. Performance is not as good as 
"real" SKAS, but the good thing is that to the main parts of the UML 
kernel memory management there is no difference other than performance and 
also that the SKAS model is behaving much better in terms of being a host 
process. Due to the better behaviour of UML in SKAS0 mode gdb can be used 
directly on the kernel just as you gdb any other application.

TT mode on the other hand implements memory (and even process) management 
very differently, behaving very oddly in terms of what a host process 
normally does. For this reason you can't gdb TT mode directly and instead 
have to use the debug option asking TT mode to gdb itself with some very 
magic tricks.

Regards
Henrik





-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
