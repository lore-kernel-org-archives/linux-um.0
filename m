Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cwn1O-0007MA-TC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 11:52:10 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cwn1N-00069x-PW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 11:52:10 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 2.6] 4/7 replace uml_strdup by kstrdup
References: <1107228511.41fef75f4a296@webmail.grupopie.com>
	<84144f02050201235257d0ec1c@mail.gmail.com>
	<4200BFA1.2060808@grupopie.com>
In-Reply-To: <4200BFA1.2060808@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032051.18191.blaisorblade@yahoo.it>
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
Date: Thu, 3 Feb 2005 20:51:17 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Paulo Marques <pmarques@grupopie.com>, Pekka Enberg <penberg@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi

On Wednesday 02 February 2005 12:55, you wrote:
> Pekka Enberg wrote:
> > On Tue,  1 Feb 2005 03:28:31 +0000, pmarques@grupopie.com
> >
> > <pmarques@grupopie.com> wrote:
> >>diff -buprN -X dontdiff
> >> vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c
> >> linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c ---
> >> vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c      
> >> 2004-12-24 21:35:40.000000000 +0000 +++
> >> linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c 2005-01-31
> >> 20:39:08.591154025 +0000
> >
> > [snip]
> >
> >>-               pri->dev_name = uml_strdup(buffer);
> >>+               pri->dev_name = kstrdup(buffer);
> >
> > Please compile-test before submitting.
>
> I'm really sorry about this...
>
> I've compiled with an allyesconfig to validate the changes, but that
> doesn't build the UML parts :(

Well, the answer is to do add a "ARCH=um" to the build commands... you could 
maybe use a "make defconfig ARCH=um" however because UML itself, sometimes, 
does not build with allyesconfig /allmodconfig...

However, that said, there are bigger problems for UML.

Since of its particular nature, it contains some code which is compiled 
against userspace headers. For instance cow_user.c (the list includes 
*_user.c and everything that is explicitly listed in USER_OBJS inside the 
Makefiles)

So, for cow_user.c, when you add <linux/string.h> to cow_user.c, you are 
actually making it include /usr/include/linux/string.h...

For UML, you should probably add the prototype to a good header inside 
arch/um/include (those headers are in the searchpath for every file under 
arch/um) - probably the one which declared uml_strdup. Yes, we have had to 
duplicate prototypes for many functions... for inlines, we've had to provide 
in many case a non-inline version.

> Anyway, thanks for pointing this out. I still haven't got feedback
> regarding the acceptance of these patches. If there is a chance they're
> accepted, maybe the best thing to do is to post the series again with
> this correction and the sound patch corrections.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
