Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EeyVo-0007LR-H6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Nov 2005 09:34:28 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EeyVh-0001Pp-IX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Nov 2005 09:34:23 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Funkiness in uml Kconfig.
References: <200511230519.32588.rob@landley.net>
In-Reply-To: <200511230519.32588.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511231834.05167.blaisorblade@yahoo.it>
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
Date: Wed, 23 Nov 2005 18:34:04 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>

On Wednesday 23 November 2005 12:19, Rob Landley wrote:
> So you may have seen the miniconfig stuff wander by, which means that my
> build script exits if there's a .config error, and we have this:
>
> fs/Kconfig:1749:warning: 'select' used by config symbol 'CIFS_UPCALL' refer
> to undefined symbol 'CONNECTOR'
>
> This makes it shut up:
>
> Signed-off-by: Rob Landley <rob@landley.net>
In short:

Acked-by: Paolo 'Blaisorblade' Giarrusso

forward this to Jeff Dike explicitly, with an inclusion-ready changelog.

However, please make sure that the menu appears in a meaningful location 
(ideally should more or less match i386).

> ---
> --- linux-2.6.14/arch/um/Kconfig 2005-11-23 05:13:33.162339168 -0600
> +++ linux-2.6.15-rc2/arch/um/Kconfig 2005-11-23 05:05:56.000000000 -0600
> @@ -289,6 +289,8 @@
>
>  source "drivers/net/Kconfig"
>
> +source "drivers/connector/Kconfig"
> +
>  source "fs/Kconfig"
>
>  source "security/Kconfig"
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
