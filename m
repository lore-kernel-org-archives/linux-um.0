Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFvwb-0003yK-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 07:42:05 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CFvwX-0003PT-H6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 07:42:05 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Compile error with 2.6.8 patch
References: <200410082331.08930.u3205097@anu.edu.au>
In-Reply-To: <200410082331.08930.u3205097@anu.edu.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410081642.03317.blaisorblade_spam@yahoo.it>
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
Date: Fri, 8 Oct 2004 16:42:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: James Roper <u3205097@anu.edu.au>

On Friday 08 October 2004 15:31, James Roper wrote:
> I got the following compile error with the latest 2.6.8.1-1 UML patch from
> the website:
> arch/um/kernel/ksyms.c:90: error: redefinition of
> `__kcrctab_os_ioctl_generic' arch/um/kernel/ksyms.c:76: error:
> `__kcrctab_os_ioctl_generic' previously defined here
>
> Fixed it by removing the extra
> EXPORT_SYMBOL(os_ioctl_generic);
> at line 90 in ksyms.c
Yes, sorry, the fix is right, this bug is known, and is fixed in the 
incremental patches. It wasn't noticed on release because it does not show up 
when compiling without module support as Jeff Dike is used to do.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
