Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUhNj-0003QG-Tx	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Oct 2005 02:15:39 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EUhNf-0000my-9g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Oct 2005 02:15:39 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
	<20051026002200.1ebb06f2.akpm@osdl.org>
In-Reply-To: <20051026002200.1ebb06f2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261119.30429.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH 1/6] Uml - reuse i386 cpu-specific tuning
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
Date: Wed, 26 Oct 2005 11:19:30 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 26 October 2005 09:22, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> >  arch/i386/Kconfig      |  304
> > ------------------------------------------------ arch/i386/Kconfig.cpu  |
> >  305 ++++++++++++++++++++++++++++++++++++++++++++++++
>
> Have mercy.  I currently have twelve patches which alter arch/i386/Kconfig
> and this patch conflicts with most of them.  This shouldn't come as a
> surprise - Kconfig files are oft-patched, and this is x86.

Yep - if we get no objection with this, I could pull any changes in -mm and 
merge the patch directly Linuswards at some point, since it has so many 
conflicts.

So, you can probably leave what you have there.
> What I did was to simply copy the large block between

> 	if !X86_ELAN
>
> and
>
> 	config X86_OOSTORE
>
> over into Kconfig.cpu, taking the modifications with it.

I also took X86_TSC with me, in my patch.

> As long as that's also what you did things should work OK.  If you actually
> made any changes as you did the copy-and-paste, we're screwed.

No, I didn't do real changes - I just added a couple of comments. However yes, 
should have splitout in copy+paste and changes

+# Put here option for CPU selection and depending optimization
[...]
and the comment near "endif" to say what is it closing:
+#!X86_ELAN

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
