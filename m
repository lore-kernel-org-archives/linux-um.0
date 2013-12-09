Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antoine@nagafix.co.uk>) id 1Vq3qc-0005zb-TN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 16:38:18 +0000
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vq3qa-0008A0-LK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Dec 2013 16:38:18 +0000
Message-ID: <52A5F1EC.2070502@nagafix.co.uk>
Date: Mon, 09 Dec 2013 23:38:04 +0700
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <2103356.guehJfKbl6@sandpuppy> <20131209082014.GA26598@kroah.com>
In-Reply-To: <20131209082014.GA26598@kroah.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7984872913858002375=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Please add: um: add missing declaration of
 'getrlimit()' and friends
To: Greg KH <gregkh@linuxfoundation.org>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, stable@vger.kernel.org

This is a multi-part message in MIME format.
--===============7984872913858002375==
Content-Type: multipart/alternative;
	boundary="------------090909020609040406070603"

This is a multi-part message in MIME format.
--------------090909020609040406070603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 09/12/13 15:20, Greg KH wrote:
> On Mon, Dec 09, 2013 at 08:33:59AM +0100, Richard Weinberger wrote:
>> Hi Greg,
>>
>> please add commit fdfa4c952844fce881df8c76de9c7180cbe913ab (um: add missing 
>> declaration of 'getrlimit()' and friends) to -stable.
>> The change was introduced in 3.9 and needs backporting to all stable trees.
> Which "all"?  Newer than 3.9 you mean?
No, this affects 3.4.73 too:
http://sourceforge.net/mailarchive/forum.php?thread_name=52A55556.7090009%40nagafix.co.uk&forum_name=user-mode-linux-devel
(sorry, that's all I know right now)

Antoine

--------------090909020609040406070603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 09/12/13 15:20, Greg KH wrote:<br>
    </div>
    <blockquote cite="mid:20131209082014.GA26598@kroah.com" type="cite">
      <pre wrap="">On Mon, Dec 09, 2013 at 08:33:59AM +0100, Richard Weinberger wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hi Greg,

please add commit fdfa4c952844fce881df8c76de9c7180cbe913ab (um: add missing 
declaration of 'getrlimit()' and friends) to -stable.
The change was introduced in 3.9 and needs backporting to all stable trees.
</pre>
      </blockquote>
      <pre wrap="">
Which "all"?  Newer than 3.9 you mean?</pre>
    </blockquote>
    No, this affects 3.4.73 too:<br>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <a
href="http://sourceforge.net/mailarchive/forum.php?thread_name=52A55556.7090009%40nagafix.co.uk&amp;forum_name=user-mode-linux-devel">http://sourceforge.net/mailarchive/forum.php?thread_name=52A55556.7090009%40nagafix.co.uk&amp;forum_name=user-mode-linux-devel</a><br>
    (sorry, that's all I know right now)<br>
    <br>
    Antoine<br>
  </body>
</html>

--------------090909020609040406070603--


--===============7984872913858002375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
--===============7984872913858002375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7984872913858002375==--


