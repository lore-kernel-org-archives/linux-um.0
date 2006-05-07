Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FcpGx-0006hm-Rs for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2006 12:50:31 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FcpGv-0002Ii-4h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 May 2006 12:50:32 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] do_uml_initcalls
References: <20060507125412.GA16519@Starbuck>
In-Reply-To: <20060507125412.GA16519@Starbuck>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200605072150.18891.blaisorblade@yahoo.it>
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
Date: Sun, 7 May 2006 21:50:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: tyler@agat.net

On Sunday 07 May 2006 14:54, user-mode-linux-devel-admin@lists.sourceforge.net 
wrote:
> Hi all,
>
> I was looking at the initialization code of UML and I found the function
> do_uml_initcalls :
>
> 1: static __init void do_uml_initcalls(void)
> 2: {
> 3: 	initcall_t *call;
> 4:
> 5: 	call = &__uml_initcall_start;
> 6:	 while (call < &__uml_initcall_end){;
> 7:	(*call)();
> 8:         call++;
> 9:  }
>
> First, there's a ';' at the end of line 6 : typo error I guess.

Apart from this one, everything is like the general Linux kernel. See below.

> But my point is : this function is unreadable !

> It does simply call all the functions in the ".initcall"
> section.

Not exactly, that's .uml.initcall.init; see include/asm-um/common.lds.S:

  __uml_initcall_start = .;
  .uml.initcall.init : { *(.uml.initcall.init) }
  __uml_initcall_end = .;

Also, in the section there is a list of pointers, not the functions 
themselves.

> Wouldn't it be better to call all the functions explicitely ?
>
> Because I was thinking of another problem : the modules. If some modules
> are compiled and that the init_modules functions are put in the initcall
> section, then all the modules will be loaded.

Nothing from modules is linked inside the kernel.
The function set as module_init() function is put into the above section only 
if the code is linked statically, not as module. When it's a module it's put 
somewhere so when the module is loaded that function is called.

> That was just some thoughts :p

This idea is not new for UML - the linux kernel uses the same idea 
for .initcall.init section (we do that separately because some functions must 
be called at different moments). And that works.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
