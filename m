Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpXi3-0004sH-NX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 12:06:15 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpXhs-00057w-JN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 12:06:09 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050113210056.465BEBAB5@zion>
	<200501141924.j0EJONnV003234@ccure.user-mode-linux.org>
In-Reply-To: <200501141924.j0EJONnV003234@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501142108.25724.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 04/11] uml: refuse to run without skas if no
	tt mode in
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
Date: Fri, 14 Jan 2005 21:08:25 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: blaisorblade_spam@yahoo.it, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Friday 14 January 2005 20:24, Jeff Dike wrote:
> Is it my imagination, or did you put the definition of can_do_skas under
> #ifdef UML_CONFIG_MODE_SKAS and failed to do the same for the call?

Look at the end:

 #else
+int can_do_skas(void)
+{
        return(0);
-#endif
 }
+#endif

This dummy call could be inlined / moved, anyway this is not performance 
critical - it's anyway nicer to have such null defines in headers. I'll clean 
it up.

While checking your statement, I also discovered that here:

int mode_tt = DEFAULT_TT;
(where DEFAULT_TT is a macro depending on CONFIG options, which is always 0 
except if SKAS mode is disabled)

is ignored, because of the subsequent:

        mode_tt = force_tt ? 1 : !can_do_skas();

So we can probably get rid of DEFAULT_TT. I'll do this in the future.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
