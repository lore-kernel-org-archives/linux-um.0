Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp5uN-0004lp-TK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 06:52:51 -0700
Received: from smtp.telkom.net.id ([203.130.196.196])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bp5uN-00077P-01 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 06:52:51 -0700
From: Mulyadi Santosa <a_mulyadi@telkom.net>
Reply-To: a_mulyadi@telkom.net
Subject: Re: [uml-devel] Kallsyms on UML
References: <20040726002724.GA11374@kevlar.burdell.org>
	<web-1072592@b1.c.plasa.com>
	<20040726060108.GA17971@kevlar.burdell.org>
In-Reply-To: <20040726060108.GA17971@kevlar.burdell.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407262045.35821.a_mulyadi@telkom.net>
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
Date: Mon, 26 Jul 2004 20:45:35 +0700
To: Sonny Rao <sonny@burdell.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

hello Sonny :-)

> I was referring to the stack traces which appear after an Oops or
> panic, or if you is simply call dump_stack() somewhere.  Normally, if
> CONFIG_KALLSYMS isn't defined in the kernel's .config file, then those
> stack traces don't show function names, just the address of the
> function, which is somewhat annoying to decode :)

Oh...sorry...looks like I am misinterpreting your e-mail :-)

ehm, AFAIK, stack frame pointer also determine the precision of stack dump, so 
make sure you don't include -fomit-frame-pointer

CONFIG_KALLSYMS, ehm, for 2.6, right? well, I still use 2.4....that's why I 
miss that option :-)

> Fortunately, an in-kernel symbol table has been added in 2.6 which
> does the work for you.  It doesn't seem to work out of the box on UML
> on 2.6, and I was just wondering if it would be trivial to add that
> support to UML.  It seems that way to me, and its a rather useful
> feature for people using UML as a kernel development tool.

Yes, I agree. Bulls-eye stack dump is definitely useful to pin point 
problem....and of course...you still need to fully understand the inner work. 
it reminds me to Linus' wise word "Use the source,Luke"  :-). Well, somehow I 
need to pratice my Force's power to achieve Jedi senior warrior :-)))

regards

Mulyadi



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
