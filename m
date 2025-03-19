Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F061C3ABA0
	for <linux-um@archiver.kernel.org>; Fri, 18 Apr 2025 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YAciZfuoMKuWSR7eQBgdr98ucgp4qUAEyHPTl4MU2Sc=; b=OYF5LPhUb0auc8HvykeYUTwEN3
	bqflB0nDc0fAnKfCZUnyEAB53igcfEB3F0H2F19ljyQhKL0hbv5whw32hwHjv4ZH8N1LsXyni1bs5
	+i2PPrR5RK2gRxHAQsrZlxtCKjfhvQMGmJa38JPmNZ5fqJs5hG1zt0sdafdHN8v13mscpRK6NKjKY
	ggVN4+eEuTLqo7jdqCRxkrCJsxeAeGFGk+qccqHapP3MwJ3g7Y+7tNieZmpoehmwiq//n9j4c9ZGv
	9AAzS6HZX1aVpgHNLlNoHxp1GQ3+jJMKWBUYIV6eaYrIN2FRoXdW45TWzbMm4M+w3damUQv1sQr9E
	+4zKm3UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5qku-0000000HVJl-0gOo;
	Fri, 18 Apr 2025 18:48:04 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuqZE-00000008eDn-1cvf;
	Wed, 19 Mar 2025 10:22:33 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-abbd96bef64so1160335566b.3;
        Wed, 19 Mar 2025 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742379750; x=1742984550; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAciZfuoMKuWSR7eQBgdr98ucgp4qUAEyHPTl4MU2Sc=;
        b=lYpcpSNFOq5yX8xCMKV4UfIyhunC3T24flibX+drveuZCPKbUGBCTRVb5istQNORPi
         lOekH7i9K97PKI5dwcgLpfoO33n+UIvhhVadJugGiZXrDNjmKEMsSi1NE2PCuL/5EUAZ
         uSeVg/UWPnugp1/cHACTM4zxOWffixUxwP3vOJiRj7qlyUmuQ58fuGLSkZcIIsjdxQUW
         ZJMMWvNkI3n8wsMdGvFIeuuXoCN4BYSFMNoa7Mb0P7/c0g+no+MgySwB6cI8SlbYJgz0
         brD4CR1Z0iPnZdlp4sfpoRrPUPuxbbPeYcT+rwK5k9DQZRR6Gfbv/rNBSea301LkH7Jg
         lgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379750; x=1742984550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAciZfuoMKuWSR7eQBgdr98ucgp4qUAEyHPTl4MU2Sc=;
        b=Xm7m+ReMMkQ9klsJ0bTCQ5MPoNgeMkR7cUDdQw3pTuT7uqnYO7E54LW7kILkmuykli
         QMAoi7WEOUS41hLGbXpYqE50KQZo1xtX/YFn9Mj1Xl0FXGxDUfPxrGmONA8AZt32uGd8
         igIRGamHtQArQ5YxAkGJGxjkU8lompEPbNeUnSw2ousEfK9mkl7vGuuuh2s70Y+T1b3D
         x2Uu5pQdDqDm/UQfHN3tCWaznU65JsTlLjsar4kee6M5QjI5Wr1/eb3NZALIbO67NEx+
         PXtKaq5567QH2htJD203OgddbOmthJcujlnWv6koclN9OxpXDqeEC/60bzaPTFg/WESC
         RTtg==
X-Forwarded-Encrypted: i=1; AJvYcCUAMtnfnxMlc9TM7MZDYyp2FR0jTiAHd4cZBfA3JDIwcrhU107WB8IlieoTh4DspU1tkYmFUM9hlk5ePzfaxzKBpw==@lists.infradead.org, AJvYcCVHxMW+vFiAmIC1ztniV8OiBOcQnSI/kQIS1jE2Jdmjb3+K1RL/WesgEgGoDwg1hldYED8sLkp5ffY5D4U=@lists.infradead.org, AJvYcCVsba/qnBXI9j2dqDFr2m1zsDoYwq206J9YoTPmbfaC02ePdm2SmVwOGeLLijEAY2Spk+mmK2c1O9wWhSg6saY=@lists.infradead.org, AJvYcCWJNWw65RxT8x0zBhewFEQTDXfMMNHd3LquKuJnpgIvCsZ3Kt4+m6a2+eZ/VGeQ3XGiRNIuPIifnmO76nr30r0=@lists.infradead.org, AJvYcCWklEiyzcxfIERoFwysXJXAsPgeQ8zklwDAl87qVAnjN7S+tvaEa4iaFRKwCjMgQ4pXX1ht4sRnFPDn/SSZUJwrfg==@lists.infradead.org, AJvYcCXA1ZHmHG++Se4RWwuEUGWKodjI//6347m6ANPfB1Hzi1pdO4AHK0RpaaFLZnJKXpprn/POCD3osCA=@lists.infradead.org, AJvYcCXscPIYguL8WWpPkSWDDcTwCu6Vm39qAHS2txS97vl/42aVZQ0gj2fdjPUX91n2YA9je51Dl4McfXYKiNiK@lists.infradead.org
X-Gm-Message-State: AOJu0YyjupAjLqgUbu4pwqYMb+es8jsaMiu101gyO9TSYge/Ren/0HRn
	s/SHwCbtnzpytNIAhOGXi23APEe4aBs4kPE/SFdMhMyMNWTW1TlOhFTc0KRj7Um3+kjPYE3FUHg
	wMNrJFYwQnOIn99IBnEyEqkoGlGk=
X-Gm-Gg: ASbGncuhsyOOprVPOcDNHBp4ZoP41cJFP6kyhUrpnQPNQVzaEbrRornXVUzch7Dcx19
	TcthaKeHq4lq6rFDmUpzv/sl1B1ylbpNp9T/EpnoiIomM4MgGFXCPiMTTDZ9JAsMSJ93rw5SKTH
	rcz6auDElYGX5F6HNaZiTELNeG3BhA
X-Google-Smtp-Source: AGHT+IFUke584GUxH6BvQB3fX7lUAUv9QcZ9e9muiwjx2XhCfAyl6Rwt1VC/I5GgI047etAZIOOFi7pICkkhLIq8oi8=
X-Received: by 2002:a17:906:f59f:b0:ac3:97f4:9c08 with SMTP id
 a640c23a62f3a-ac3b7de1176mr194902266b.31.1742379749621; Wed, 19 Mar 2025
 03:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250319092951.37667-1-jirislaby@kernel.org>
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Mar 2025 12:21:53 +0200
X-Gm-Features: AQ5f1JplWeGobilHQOGjnSRx3FqTIg2f9LEWqzrz_L_kygQImpD-DssVqoDvovg
Message-ID: <CAHp75VfJPgaGyERBaSxSGap+Daeuy8kOjyjg+QkCtzxUydzHiQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/57] irqdomain: Cleanups and Documentation
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Abhinav Kumar <quic_abhinavk@quicinc.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Alex Deucher <alexander.deucher@amd.com>, Alex Shi <alexs@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, amd-gfx@lists.freedesktop.org, Amit Kucheria <amitk@kernel.org>, Anatolij Gustschin <agust@denx.de>, Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Andreas Kemnade <andreas@kemnade.info>, Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andy@kernel.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Antoine Tenart <atenart@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>, asahi@lists.linux.dev, Bartosz Golaszewski <brgl@bgdev.pl>, Baruch Siach <baruch@tkos.co.il>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>, Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Corentin Chary <corentin.chary@gmail.com>, Daire McNamara <daire.mcnamara@microchip.com>, Daniel Golle <daniel@makrotopia.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Daniel Mack <daniel@zonque.org>, Daniel Palmer <daniel@thingy.jp>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Dongliang Mu <dzm91@hust.edu.cn>, Doug Berger <opendmb@gmail.com>, dri-devel@lists.freedesktop.org, Eddie James <eajames@linux.ibm.com>, Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Geoff Levand <geoff@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Clement <gregory.clement@bootlin.com>, Guo Ren <guoren@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Herve Codina <herve.codina@bootlin.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen <chenhuacai@kernel.org>, Changhuang Liang <changhuang.liang@starfivetech.com>, Chen-Yu Tsai <wens@csie.org>, "Chester A. Unal" <chester.a.unal@arinc9.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Chris Zankel <chris@zankel.net>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Imre Kaloz <kaloz@openwrt.org>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, James Morse <james.morse@arm.com>, Janne Grunau <j@jannau.net>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Jassi Brar <jassisinghbrar@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Jianjun Wang <jianjun.wang@mediatek.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Jim Quinlan <jim2101024@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Joel Stanley <joel@jms.id.au>, Johannes Berg <johannes@sipsolutions.net>, John Crispin <john@phrozen.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonas Bonn <jonas@southpole.se>, Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jonathan Hunter <jonathanh@nvidia.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Joyce Ooi <joyce.ooi@intel.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Linus Walleij <linusw@kernel.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-remoteproc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, loongarch@lists.linux.dev, Lorenzo Pieralisi <lpieralisi@kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Lukasz Luba <lukasz.luba@arm.com>, "Luke D. Jones" <luke@ljones.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, Mark Brown <broonie@kernel.org>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, Michael Buesch <m@bues.ch>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <michal.simek@amd.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Naveen N Rao <naveen@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Nipun Gupta <nipun.gupta@amd.com>, Nishanth Menon <nm@ti.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Cercueil <paul@crapouillou.net>, Paul Walmsley <paul.walmsley@sifive.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Peter Rosin <peda@axentia.se>, Philipp Zabel <p.zabel@pengutronix.de>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, platform-driver-x86@vger.kernel.org, Prasad Kumpatla <quic_pkumpatl@quicinc.com>, Qiang Zhao <qiang.zhao@nxp.com>, Qin Jian <qinjian@cqplus1.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Ray Jui <rjui@broadcom.com>, Rengarajan Sundararajan <Rengarajan.S@microchip.com>, Richard Cochran <richardcochran@gmail.com>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Rob Clark <robdclark@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Robert Richter <rric@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, Russell King <linux@armlinux.org.uk>, Ryan Chen <ryan_chen@aspeedtech.com>, Ryder Lee <ryder.lee@mediatek.com>, Samuel Holland <samuel@sholland.org>, Santosh Shilimkar <ssantosh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Scott Branden <sbranden@broadcom.com>, Scott Wood <oss@buserror.net>, Sean Paul <sean@poorly.run>, Sean Wang <sean.wang@kernel.org>, Sean Wang <sean.wang@mediatek.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Simona Vetter <simona@ffwll.ch>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stephen Boyd <sboyd@kernel.org>, Sven Peter <sven@svenpeter.dev>, Takashi Iwai <tiwai@suse.com>, Talel Shenhar <talel@amazon.com>, Tero Kristo <kristo@kernel.org>, Thangaraj Samynathan <Thangaraj.S@microchip.com>, Thara Gopinath <thara.gopinath@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Toan Le <toan@os.amperecomputing.com>, Tony Lindgren <tony@atomide.com>, Tony Luck <tony.luck@intel.com>, UNGLinuxDriver@microchip.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Vineet Gupta <vgupta@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, WANG Xuerui <kernel@xen0n.name>, Woojung Huh <woojung.huh@microchip.com>, x86@kernel.org, Yanteng Si <si.yanteng@linux.dev>, Yoshinori Sato <ysato@users.sourceforge.jp>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_032232_433578_04F53A6F 
X-CRM114-Status: GOOD (  22.24  )
X-Mailman-Approved-At: Fri, 18 Apr 2025 11:48:00 -0700
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Mar 19, 2025 at 11:30=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:
>
> Hi,
>
> tl;dr if patches are agreed upon, I ask subsys maintainers to take the
> respective ones via their trees (as they are split per subsys), so that
> the IRQ tree can take only the rest. That would minimize churn/conflicts
> during merges.
>
> =3D=3D=3D
>
> While I was reading through the irqdomain code and headers, I found some
> naming and documentation hard to follow or incomplete. Especially the
> naming of _add/_create/_instantiate functions.
>
> I tried to come up with a better state with this patchset:
> * only irq _domain_ (not host),
> * only irq_domain_create*() functions, all taking fwnode uniformly,
>
> Finally, all the irqdomain stuff is now plugged (and generated) into
> Documentation. So that everyone can walk through it at
> https://www.kernel.org/doc/ (once applied, of course).

I am all to support the idea, but in some cases I would think of a bit
more work to be done to get rid of the of_fwnode_handle(np) in favour
of dev_fwnode(dev). Note, this is based on a brief look, I haven't any
example at hand right now.

--=20
With Best Regards,
Andy Shevchenko

