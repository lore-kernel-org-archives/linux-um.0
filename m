Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZxE3-0008NC-S1
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 11:02:19 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZxE3-000336-At
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 11:02:19 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML build system: patch ready
References: <200312241943.37474.blaisorblade_spam@yahoo.it> <Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312261956.24711.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 26 Dec 2003 19:56:24 +0100
To: user-mode-linux-devel@lists.sourceforge.net

> arch/um/sys-i386/bugs.c ...
[...]
> It looks that modify_ldt_ldt_s is not defined anywhere and modify_ldt()
> cannot be found.
It's true, but they should be defined by /usr/include/asm/ldt.h. So it's not 
my fault(unless you succeed in compiling a 2.6 with the -test9 patch).
Have you got a Debian? This problem has appeared on Debian unstable also for 
2.4, since that file is from the 2.6 headers.
The quick fix is to make /usr/include/asm and /usr/include/linux be symlinks 
into a 2.4 kernel tree, but only for compiling UML(for the other programs, in 
fact, they must stay as they are).

> arch/um/sys-i386/bugs.c: In function `disable_lcall':
> arch/um/sys-i386/bugs.c:110: storage size of `ldt' isn't known
> arch/um/sys-i386/bugs.c:117: warning: implicit declaration of function
> `modify_ldt'
> arch/um/sys-i386/bugs.c:110: warning: unused variable `ldt'

> I did these ...
> 	cd uml
> 	patch -p1 </tar/uml/uml-combo-2.6.0-A5
> 	patch -p1 </tar/uml/A-01-Fix_clean_mrproper.patch
> 	patch -p1 </tar/uml/A-02-Apply_altern-constants.patch
> 	patch -p1 </tar/uml/A-03-Module_support.patch

That's ok(apart for the uml-combo, I didn't test it), but I wasn't clear about 
A-04.
You can apply A-04-User_obj_makefiles-v2.patch(note the -v2), while you must 
not apply A-04-User_obj_makefiles.patch (now I've seen this wasn't uploaded). 
However that is unrelated to the above problem. Also, if you want some more 
to test, see my new message "UML patches against vanilla 2.6.0", which 
describes a more complete group of patches.

-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
