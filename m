Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx2rI-0004qN-R6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 04:46:48 -0800
Received: from [195.23.16.24] (helo=bipbip.comserver-pie.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cx2rI-0003P7-8J for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 04:46:48 -0800
Message-ID: <42036E6F.1080104@grupopie.com>
From: Paulo Marques <pmarques@grupopie.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [PATCH 2.6] 4/7 replace uml_strdup by kstrdup
References: <1107228511.41fef75f4a296@webmail.grupopie.com>
	<84144f02050201235257d0ec1c@mail.gmail.com>
	<4200BFA1.2060808@grupopie.com>
	<200502032051.18191.blaisorblade@yahoo.it>
In-Reply-To: <200502032051.18191.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 04 Feb 2005 12:45:35 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Pekka Enberg <penberg@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi

Blaisorblade wrote:
>[...]
> For UML, you should probably add the prototype to a good header inside 
> arch/um/include (those headers are in the searchpath for every file under 
> arch/um) - probably the one which declared uml_strdup. Yes, we have had to 
> duplicate prototypes for many functions... for inlines, we've had to provide 
> in many case a non-inline version.

Thanks for the tip. I'll have to read the code more carefully to 
understand better where the userspace ends and the kernel begins, so 
that I don't do similar mistakes in the future.

I'll redo the patch and post it for review, probably during next week. I 
don't think there is much hurry, because, even if this gets accepted, it 
should go in only in 2.6.12-rc1-mm1 or something like that, so there is 
still time to review this more carefully.

Thanks for reviewing the patch,

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
