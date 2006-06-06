Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo5nn-0006LL-BC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 14:42:59 -0700
Received: from ug-out-1314.google.com ([66.249.92.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fo5nl-0001if-VD
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 14:42:59 -0700
Received: by ug-out-1314.google.com with SMTP id u2so536939uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 07 Jun 2006 14:42:56 -0700 (PDT)
Message-ID: <b921df970606060518y3cdf8f83i28679f274aa45ce0@mail.gmail.com>
Date: Tue, 6 Jun 2006 14:18:27 +0200
From: "Alessandro Corradi" <ale.corradi@gmail.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [NEWBYE]
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1364902196=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

--===============1364902196==
Content-Type: multipart/alternative; 
	boundary="----=_Part_23863_22510992.1149596307139"

------=_Part_23863_22510992.1149596307139
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>On Thursday 01 June 2006 18:09, Alessandro Corradi wrote:
>> Hi to everyboby,
>> I'm preparing the degree's thesis about uml. I'm searching about device
>> forwarding, eg. HOST->ttyS0 <---> UML->ttyS0
>> I must see how this connection works. Then I must to handle it for
>> remapping a virtual device in the host.
>> Can you recommend me where is the right code to look up? (or a initial
>> trace)
>> Thanks
>You should add to the initial uml command line something like
>"ssl0=tty:/dev/ttyS0", where ssl0 means "Uml first serial line" and after =
>you have the same syntax as for UML consoles.
>
>You can find all details on:
>
>http://user-mode-linux.sourceforge.net/input.html<http://user-mode-linux.sourceforge.net/input.html>

Ok thanks, but I must to know how it works inside UML, I need to know where
is the source to look up the mechanism. I need it cause I have to manipulate
it for connect a simple virtual device in the host to UML.


I don't know if I have made sense of well but the most important thing is
that i understand how simple device communicate with UML

------=_Part_23863_22510992.1149596307139
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div style="direction: ltr;"><span class="q">&gt;On Thursday 01 June 2006 18:09, Alessandro Corradi wrote:<br>&gt;&gt; Hi to everyboby,<br>&gt;&gt; I'm preparing the degree's thesis about uml. I'm searching about device<br>
&gt;&gt; forwarding, eg. HOST-&gt;ttyS0 &lt;---&gt; UML-&gt;ttyS0<br>&gt;&gt; I must see how this connection works. Then I must to handle it for<br>&gt;&gt; remapping a virtual device in the host.<br>&gt;&gt; Can you recommend me where is the right code to look up? (or a initial
<br>&gt;&gt; trace)<br>&gt;&gt; Thanks<br></span></div>&gt;You should add to the initial uml command line something like<br>&gt;&quot;ssl0=tty:/dev/ttyS0&quot;, where ssl0 means &quot;Uml first serial line&quot; and after =
<br>&gt;you have the same syntax as for UML consoles.<br>&gt;<br>&gt;You can find all details on:<br>&gt;<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://user-mode-linux.sourceforge.net/input.html" target="_blank">
&gt;http://user-mode-linux.sourceforge.net/input.html</a><br><br>Ok thanks, but I must to know how it works inside UML, I need to know where is the source to look up the mechanism. I need it cause I have to manipulate it for connect a simple virtual device in the host to UML.
<br><br><br>I don't know if I have made sense of well but the most important thing is that i understand how simple device communicate with UML<br><br>

------=_Part_23863_22510992.1149596307139--


--===============1364902196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1364902196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1364902196==--
