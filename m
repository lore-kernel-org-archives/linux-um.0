Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com>
 <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
 <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
In-Reply-To: <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Dec 2019 06:01:09 +0000
Message-ID: <CACPK8XdgGLLT=RprY8zVW6kKJ6fjJdm4Oxs0uHBv-W5StMyGPQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Andrew Jeffery <andrew@aj.id.au>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Thu, 12 Dec 2019 at 00:30, Brendan Higgins <brendanhiggins@google.com> wrote:
>
> On Wed, Dec 11, 2019 at 4:12 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Nice. I hit this when attempting to force on CONFIG_COMPILE_TEST in
> > order to build some ARM drivers under UM. Do you have plans to fix
> > that too?
>
> The only broken configs I found for UML are all listed on the cover
> letter of this patch. I think fixing COMPILE_TEST on UM could be
> worthwhile. Did you see any brokenness other than what I mentioned on
> the cover letter?

There's a few more in drivers/char/hw_random that you would need.
These were HW_RANDOM_MESON , HW_RANDOM_MTK, HW_RANDOM_EXYNOS,
HW_RANDOM_NPCM, HW_RANDOM_KEYSTONE.

The only one from your series I needed was PINCTRL_EQUILIBRIUM.

I applied this:

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -91,7 +91,6 @@ config INIT_ENV_ARG_LIMIT

 config COMPILE_TEST
        bool "Compile also drivers which will not load"
-       depends on !UML
        default n
        help

That lets me build. However, the code I was attempting to enable
depends on REGMAP, which needs IOMEM too, so I hit that dead end.

Another issue I had was debugging my kunitconfig. This patch helped a bit:

--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -40,6 +40,9 @@ class Kconfig(object):
        def is_subset_of(self, other: 'Kconfig') -> bool:
                return self.entries().issubset(other.entries())

+       def difference(self, other: 'Kconfig') -> list:
+               return self.entries().difference(other.entries())
+
        def write_to_file(self, path: str) -> None:
                with open(path, 'w') as f:
                        for entry in self.entries():
diff --git a/tools/testing/kunit/kunit_kernel.py
b/tools/testing/kunit/kunit_kernel.py
index bf3876835331..0f261bc087e4 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -107,6 +107,7 @@ class LinuxSourceTree(object):
                validated_kconfig.read_from_file(kconfig_path)
                if not self._kconfig.is_subset_of(validated_kconfig):
                        logging.error('Provided Kconfig is not
contained in validated .config!')
+
logging.error(self._kconfig.difference(validated_kconfig))
                        return False
                return True

Which would need some tidying up before applying, but helped a lot in
working out what was going wrong.

>
> > Do you want to get this in a fix for 5.5?
>
> Preferably, yes.
>
> > Acked-by: Joel Stanley <joel@jms.id.au>
>
> Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

