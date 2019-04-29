Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hL5dA-0001dM-Hn
 for linux-um@lists.infradead.org; Mon, 29 Apr 2019 12:43:38 +0000
Received: by mail-qt1-f194.google.com with SMTP id p20so11629951qtc.9
 for <linux-um@lists.infradead.org>; Mon, 29 Apr 2019 05:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202839.248216-1-arnd@arndb.de>
 <s5hk1fthx9u.wl-tiwai@suse.de> <s5hv9yxjnp4.wl-tiwai@suse.de>
In-Reply-To: <s5hv9yxjnp4.wl-tiwai@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 Apr 2019 14:43:18 +0200
Message-ID: <CAK8P3a1CbQsyTBykXkZv-35M_zQx97aOubtZD2YuzyPV94+4=w@mail.gmail.com>
Subject: Re: [PATCH v3 20/26] compat_ioctl: remove translation for sound ioctls
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, y2038 Mailman List <y2038@lists.linaro.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Vinod Koul <vkoul@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>

On Mon, Apr 29, 2019 at 9:05 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 17 Apr 2019 10:05:33 +0200, Takashi Iwai wrote:
> >
> > On Tue, 16 Apr 2019 22:28:05 +0200, Arnd Bergmann wrote:
> > > The compat_ioctl list contains one comment about SNDCTL_DSP_MAPINBUF and
> > > SNDCTL_DSP_MAPOUTBUF, which actually would need a translation handler
> > > if implemented. However, the native implementation just returns -EINVAL,
> > > so we don't care.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This looks like a really nice cleanup.  Thanks!
> >
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
>
> Is this supposed to be taken via sound git tree, or would you apply
> over yours?  I'm fine in either way.

I was hoping that Al could pick up the entire series to avoid the merge
conflicts, but then we had some more discussion about the earlier
patches in the series and he did another version of those.

Al, what is your current plan for the compat-ioctl removal series?
Are you working on a combined series, or should I resend a
subset of my patches to you?

       Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

