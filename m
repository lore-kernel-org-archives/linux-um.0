Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3OCT-0006ym-Jp
 for linux-um@lists.infradead.org; Thu, 29 Aug 2019 17:27:11 +0000
Message-ID: <605f243573cd0e0f14c995f6850984b4dca2a50c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 29 Aug 2019 19:27:01 +0200
In-Reply-To: <20190829130804.5e644540@TheDarkness>
References: <20190828204609.02a7ff70@TheDarkness>
 <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
 <20190829103628.61953f50@thedarkness.local>
 <1851013915.76434.1567092659763.JavaMail.zimbra@nod.at>
 <20190829130804.5e644540@TheDarkness>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Dark <dark@volatile.bz>, Richard Weinberger <richard@nod.at>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton ivanov <anton.ivanov@cambridgegreys.com>

On Thu, 2019-08-29 at 13:10 -0400, Dark wrote:
> (I'm unsure of how to submit an update
> to my patch so I'll need a bit of guidence on this.)

Resend the patch, but use --subject-prefix 'PATCH v2' and ideally note
somewhere in the patch (possibly after a "---" marker after Signed-off-
by) the changes between the versions, like

[...]
Signed-off-by: ...
---
v2:
 * fix -EAGAIN handling
[...]

Hmm, but looks like you didn't actually use git send-email directly, so
I guess just put "[PATCH v2]" manually.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

