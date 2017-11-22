Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1eHRWH-00063a-FK
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 09:40:37 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1eHRWA-0001Wb-WB for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 09:40:37 +0000
Received: from tun5.smaug.kot-begemot.co.uk ([192.168.18.6]
 helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1eHRW5-0005Tn-0J for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 09:40:25 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
 by smaug.kot-begemot.co.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1eHRW4-00017R-OU
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 22 Nov 2017 09:40:24 +0000
References: <201711221745.R0byKNwn%fengguang.wu@intel.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <5d657abb-eea2-2c3a-35f8-769046b20a48@kot-begemot.co.uk>
Date: Wed, 22 Nov 2017 09:40:18 +0000
MIME-Version: 1.0
In-Reply-To: <201711221745.R0byKNwn%fengguang.wu@intel.com>
Content-Language: en-US
Subject: Re: [uml-devel] [uml:for-linus-4.15-rc1 5/6] ERROR:
 "free_irq_by_fd" [arch/um/drivers/random.ko] undefined!
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3406659698250042610=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3406659698250042610==
Content-Type: multipart/alternative;
 boundary="------------103CE6364A8141FE33C0908A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------103CE6364A8141FE33C0908A
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

weird

free_irq_by_fd is defined by irq_user which is included by os.h and that 
is included by random.c

I do not quite see how it could end up undefined.

A.


On 11/22/17 09:33, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.15-rc1
> head:   ad1f62ab2bd43b962127af760d59a25ae1c93681
> commit: d4560bdc6d38f5c3bf5889fd95c954b6b5949fab [5/6] Epoll based IRQ controller
> config: um-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>          git checkout d4560bdc6d38f5c3bf5889fd95c954b6b5949fab
>          # save the attached .config to linux build tree
>          make ARCH=um
>
> All errors (new ones prefixed by >>):
>
>     ERROR: "devm_ioremap_resource" [drivers/auxdisplay/img-ascii-lcd.ko] undefined!
>>> ERROR: "free_irq_by_fd" [arch/um/drivers/random.ko] undefined!
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>
>
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


--------------103CE6364A8141FE33C0908A
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>weird</p>
    <p>free_irq_by_fd is defined by irq_user which is included by os.h
      and that is included by random.c</p>
    <p>I do not quite see how it could end up undefined.<br>
    </p>
    <p>A.<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 11/22/17 09:33, kbuild test robot
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:201711221745.R0byKNwn%25fengguang.wu@intel.com">
      <pre wrap="">tree:   <a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git">https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git</a> for-linus-4.15-rc1
head:   ad1f62ab2bd43b962127af760d59a25ae1c93681
commit: d4560bdc6d38f5c3bf5889fd95c954b6b5949fab [5/6] Epoll based IRQ controller
config: um-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout d4560bdc6d38f5c3bf5889fd95c954b6b5949fab
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by &gt;&gt;):

   ERROR: "devm_ioremap_resource" [drivers/auxdisplay/img-ascii-lcd.ko] undefined!
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">ERROR: "free_irq_by_fd" [arch/um/drivers/random.ko] undefined!
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
---
0-DAY kernel test infrastructure                Open Source Technology Center
<a class="moz-txt-link-freetext" href="https://lists.01.org/pipermail/kbuild-all">https://lists.01.org/pipermail/kbuild-all</a>                   Intel Corporation
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class="moz-txt-link-freetext" href="http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
User-mode-linux-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:User-mode-linux-devel@lists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------103CE6364A8141FE33C0908A--


--===============3406659698250042610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============3406659698250042610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3406659698250042610==--


