Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUfcK-0006bZ-QC	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Oct 2005 00:22:36 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EUfcI-00075f-F1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Oct 2005 00:22:36 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20051026002200.1ebb06f2.akpm@osdl.org>
In-Reply-To: <20051025221105.21106.95194.stgit@zion.home.lan>
References: <20051025221105.21106.95194.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Wed, 26 Oct 2005 00:22:00 -0700
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
>  arch/i386/Kconfig      |  304 ------------------------------------------------
>   arch/i386/Kconfig.cpu  |  305 ++++++++++++++++++++++++++++++++++++++++++++++++

Have mercy.  I currently have twelve patches which alter arch/i386/Kconfig
and this patch conflicts with most of them.  This shouldn't come as a
surprise - Kconfig files are oft-patched, and this is x86.

What I did was to simply copy the large block between

	if !X86_ELAN

and

	config X86_OOSTORE

over into Kconfig.cpu, taking the modifications with it.

As long as that's also what you did things should work OK.  If you actually
made any changes as you did the copy-and-paste, we're screwed.



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
