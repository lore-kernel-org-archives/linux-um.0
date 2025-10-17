Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C219BCD129C
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 16:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JanebDxbE/kr6ucVM486lEx9oeuMHOmRkDUFLuDZlZo=; b=KGsgLxhT2hBDTsT3D7hcKdGAfv
	KgCpHuWDX6594vuZLdH7u8hWhi2I/EcJoYsBVch7415IYorJQJIAC8S1pbEuUuvhGkcO8PEo3AAul
	CRa8XMZ7K/7Kd6jLhkC6SzG4Ym7hbkjBtYxm3CgBpiJB1VgPjcRCY/n6F8NSah/qtvrJX8zjCUwhg
	pPv8Xgudn+dr28eUESIiy3odt7xdmebZs/WdeTYxJK2OGqYBMbAlRrvKYSE3XbLPuklfLaAGcJpeo
	8c5kLKBY9SEngEXg47py0kaUJh++zray73IjIOFPrDiyj23fKbG72rLQ4STbTlAD7h7R810AtROS9
	fGT0Ag6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHlrB-00000003Gz0-0pxh;
	Sat, 08 Nov 2025 16:32:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9j7U-00000007kQK-42kA;
	Fri, 17 Oct 2025 11:59:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AFE674B012;
	Fri, 17 Oct 2025 11:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3037FC4CEE7;
	Fri, 17 Oct 2025 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760702377;
	bh=38uFLiDTAO+A1PWpRP2bVJ1ijHpCWsegoKBcJwzF2PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSItTMlZ+xkWo77L3dJDjTz61eq44oatBXCgbcCC5ycxjVd62F5ZBD5t/I/P7IMAl
	 lQe+zy+uvgq1Iphq58yIzjQNmbjsJLGcQk9xMD89Oyn29Qra+kKcuYPJON2XTLg6Wc
	 Tx4/0gvLYtBA9RdvGnygRkoazMU/mLdzs1fx2bZA=
Date: Fri, 17 Oct 2025 13:59:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: stable@vger.kernel.org, linux@armlinux.org.uk, jdike@addtoit.com,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
	mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
	harry.wentland@amd.com, sunpeng.li@amd.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
	james.qian.wang@arm.com, liviu.dudau@arm.com,
	mihail.atanassov@arm.com, brian.starkey@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robdclark@gmail.com, sean@poorly.run,
	jdelvare@suse.com, linux@roeck-us.net, fery@cypress.com,
	dmitry.torokhov@gmail.com, agk@redhat.com, snitzer@redhat.com,
	dm-devel@redhat.com, rajur@chelsio.com, davem@davemloft.net,
	kuba@kernel.org, peppe.cavallaro@st.com, alexandre.torgue@st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, malattia@linux.it,
	hdegoede@redhat.com, mgross@linux.intel.com,
	intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	sakari.ailus@linux.intel.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, xiang@kernel.org, chao@kernel.org, jack@suse.com,
	tytso@mit.edu, adilger.kernel@dilger.ca, dushistov@mail.ru,
	luc.vanoostenryck@gmail.com, rostedt@goodmis.org, pmladek@suse.com,
	sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, minchan@kernel.org, ngupta@vflare.org,
	akpm@linux-foundation.org, kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, jmaloy@redhat.com, ying.xue@windriver.com,
	willy@infradead.org, sashal@kernel.org, ruanjinjie@huawei.com,
	David.Laight@aculab.com, herve.codina@bootlin.com, Jason@zx2c4.com,
	keescook@chromium.org, kbusch@kernel.org, nathan@kernel.org,
	bvanassche@acm.org, ndesaulniers@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-mm@kvack.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	tipc-discussion@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Isabella Basso <isabbasso@riseup.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sander Vanheule <sander@svanheule.net>,
	Vlastimil Babka <vbabka@suse.cz>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2 01/27 5.10.y] overflow, tracing: Define the
 is_signed_type() macro once
Message-ID: <2025101708-obtuse-ellipse-e355@gregkh>
References: <20251017090519.46992-1-farbere@amazon.com>
 <20251017090519.46992-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017090519.46992-2-farbere@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251017_045941_048260_087EC67D 
X-CRM114-Status: UNSURE (   6.61  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sat, 08 Nov 2025 08:31:09 -0800
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

On Fri, Oct 17, 2025 at 09:04:53AM +0000, Eliav Farber wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> [ Upstream commit 92d23c6e94157739b997cacce151586a0d07bb8a ]

This isn't in 5.15.y, why is it needed in 5.10.y?

thanks,

greg k-h

