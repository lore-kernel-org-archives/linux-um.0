Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwJ6f-0007A6-U4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 03:55:37 -0800
Received: from [195.23.16.24] (helo=bipbip.comserver-pie.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CwJ6e-0002j7-CL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Feb 2005 03:55:37 -0800
Message-ID: <4200BFA1.2060808@grupopie.com>
From: Paulo Marques <pmarques@grupopie.com>
MIME-Version: 1.0
References: <1107228511.41fef75f4a296@webmail.grupopie.com>
	<84144f02050201235257d0ec1c@mail.gmail.com>
In-Reply-To: <84144f02050201235257d0ec1c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 2.6] 4/7 replace uml_strdup by kstrdup
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
Date: Wed, 02 Feb 2005 11:55:13 +0000
To: Pekka Enberg <penberg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, penberg@cs.helsinki.fi

Pekka Enberg wrote:
> On Tue,  1 Feb 2005 03:28:31 +0000, pmarques@grupopie.com
> <pmarques@grupopie.com> wrote:
> 
>>diff -buprN -X dontdiff vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c
>>--- vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c       2004-12-24 21:35:40.000000000 +0000
>>+++ linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c 2005-01-31 20:39:08.591154025 +0000
> 
> 
> [snip]
> 
> 
>>-               pri->dev_name = uml_strdup(buffer);
>>+               pri->dev_name = kstrdup(buffer);
> 
> 
> Please compile-test before submitting.

I'm really sorry about this...

I've compiled with an allyesconfig to validate the changes, but that 
doesn't build the UML parts :(

Anyway, thanks for pointing this out. I still haven't got feedback 
regarding the acceptance of these patches. If there is a chance they're 
accepted, maybe the best thing to do is to post the series again with 
this correction and the sound patch corrections.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
