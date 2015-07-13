Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZEcFH-0005mi-0T
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 11:50:03 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEcFF-0006uK-2z
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 11:50:02 +0000
Message-ID: <55A3A5E0.8030802@nod.at>
Date: Mon, 13 Jul 2015 13:49:52 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>
In-Reply-To: <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258:
 possible missing call to va_end ?
To: David Binderman <dcb314@hotmail.com>, Jeff Dike <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hi!

Can you please render this into a proper patch and re-send to the mailinglist?

Thanks,
//richard

Am 13.07.2015 um 11:08 schrieb David Binderman:
> Hello there,
> 
> [linux-4.2-rc2/arch/um/drivers/net_user.c:258]: (error) va_list 'ap' was opened but not closed by va_end().
> 
> Source code is
> 
>     va_start(ap, str);
>     while ((arg = va_arg(ap, char **)) != NULL) {
>         if (*str == '\0')
>             return NULL;
>         end = strchr(str, ',');
>         if (end != str)
>             *arg = str;
>         if (end == NULL)
>             return NULL;
>         *end++ = '\0';
>         str = end;
>     }
>     va_end(ap);
>     return str;
> 
> If va_end needs to be called for successful return, it probably also
> needs to be called for NULL return (twice).
> 
> Regards
> 
> David Binderman
> 
>  		 	   		  
> 

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

