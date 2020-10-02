Return-Path: <maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 0/6] Fix new html build warnings from next-20201001
Date: Fri,  2 Oct 2020 09:19:59 +0100
Message-Id: <160162675379.1930042.15447480570555160964.b4-ty@kernel.org>
In-Reply-To: <cover.1601616399.git.mchehab+huawei@kernel.org>
References: <cover.1601616399.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: kvmarm@lists.cs.columbia.edu, David Brazdil <dbrazdil@google.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, kernel-team@android.com, Christoph Lameter <cl@linux.com>, Paolo Bonzini <pbonzini@redhat.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, kvm@vger.kernel.org, linux-i2c@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "David S. Miller" <davem@davemloft.net>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jeff Dike <jdike@addtoit.com>, Taehee Yoo <ap420073@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Richard Weinberger <richard@nod.at>, Andrew Jones <drjones@redhat.com>, Wolfram Sang <wsa@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-um@lists.infradead.org, Alexandru Elisei <alexandru.elisei@arm.com>, Balbir Singh <sblbir@amazon.com>, Jonathan Corbet <corbet@lwn.net>, Mathieu Poirier <mathieu.poirier@linaro.org>, Ulrich Hecht <uli+renesas@fpond.eu>
List-ID: <linux-um.lists.infradead.org>

On Fri, 2 Oct 2020 07:49:44 +0200, Mauro Carvalho Chehab wrote:
> There are some new warnings when building the documentation from
> yesterday's linux next. This small series fix them.
> 
> - patch 1 documents two new kernel-doc parameters on a net core file.
>   I used the commit log in order to help documenting them;
> - patch 2 fixes some tags at UMLv2 howto;
> - patches 3 and 5 add some new documents at the corresponding
>   index file.
> - patch 4 changes kernel-doc script for it to recognize typedef enums.
> 
> [...]

Applied to next, thanks!

[2/6] KVM: arm64: Fix some documentation build warnings
      commit: 030bdf3698b7c3af190dd1fe714f0545f23441d0

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.



