Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HcOgC-0006Ro-CQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 09:31:20 -0700
Received: from nz-out-0506.google.com ([64.233.162.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HcOg9-00077E-D5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Apr 2007 09:31:18 -0700
Received: by nz-out-0506.google.com with SMTP id i11so1935093nzi
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 13 Apr 2007 09:31:16 -0700 (PDT)
Message-ID: <3aab51dc0704130931q782ce158r134c6b73d4945625@mail.gmail.com>
Date: Fri, 13 Apr 2007 09:31:16 -0700
From: "Haifeng He" <hehaifeng@gmail.com>
In-Reply-To: <20070413135447.GA4975@c2.user-mode-linux.org>
MIME-Version: 1.0
References: <3aab51dc0704122214g6be916fdm148a7ff52d4e369c@mail.gmail.com>
	<20070413135447.GA4975@c2.user-mode-linux.org>
Subject: Re: [uml-devel] Strange segmentation fault
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1482655444=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============1482655444==
Content-Type: multipart/alternative; 
	boundary="----=_Part_8285_21362507.1176481876249"

------=_Part_8285_21362507.1176481876249
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/13/07, Jeff Dike <jdike@addtoit.com> wrote:
>
> On Thu, Apr 12, 2007 at 10:14:32PM -0700, Haifeng He wrote:
> > 3. foo is called at many places.
> >
> > If not, what could be the cause for such error? The strange thing is,
> > if I just read value of "a" from "current", kernel runs fine.
>
> Did you put a call in userspace_tramp?


Yes. So that is the problem. Is there any other place which may cause
similar problems?

Thanks

Haifeng

                               Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

------=_Part_8285_21362507.1176481876249
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>
<div><span class="gmail_quote">On 4/13/07, <b class="gmail_sendername">Jeff Dike</b> &lt;<a href="mailto:jdike@addtoit.com">jdike@addtoit.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thu, Apr 12, 2007 at 10:14:32PM -0700, Haifeng He wrote:<br>&gt; 3. foo is called at many places.<br>&gt;
<br>&gt; If not, what could be the cause for such error? The strange thing is,<br>&gt; if I just read value of &quot;a&quot; from &quot;current&quot;, kernel runs fine.<br><br>Did you put a call in userspace_tramp?</blockquote>

<div>&nbsp;</div>
<div>Yes. So that is the problem. Is there any other place which may cause</div>
<div>similar problems?</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>&nbsp;</div>
<div>Haifeng</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jeff<br><br>--<br>Work email - jdike at linux dot intel dot com<br></blockquote>
</div><br>

------=_Part_8285_21362507.1176481876249--


--===============1482655444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1482655444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1482655444==--

