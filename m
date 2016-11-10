Return-Path: <linux-gpio-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 20:56:38 -0500
From: Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH] gpio: Guard devm_* functions behind CONFIG_GPIO_DEVRES not
 CONFIG_GPIOLIB
Message-ID: <20161110015638.GA51357@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

These functions are defined in devres.c, which only gets compiled with
CONFIG_GPIO_DEVRES (in addition to CONFIG_GPIOLIB). However, in the
header files, the difference between the declaration and the inline
stub was only guarded by CONFIG_GPIOLIB, not CONFIG_GPIO_DEVRES,
causing undefined symbol problems in modpost.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

I encountered this while trying to build uml in an attempt to debug some kernel
behavior I don't understand. To be as close to my actual kernel as possible,
I used the same .config, which of course tried to build a bunch of drivers.
Arguably I should just not build those, but this seems correct nonetheless
and allows the build to go through.

 include/linux/gpio.h          |  28 +++---
 include/linux/gpio/consumer.h | 193 ++++++++++++++++++++++--------------------
 2 files changed, 117 insertions(+), 104 deletions(-)

diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index d12b5d5..7a1b979 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -77,15 +77,6 @@ static inline int irq_to_gpio(unsigned int irq)
 
 #endif /* ! CONFIG_ARCH_HAVE_CUSTOM_GPIO_H */
 
-/* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
-
-struct device;
-
-int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
-int devm_gpio_request_one(struct device *dev, unsigned gpio,
-			  unsigned long flags, const char *label);
-void devm_gpio_free(struct device *dev, unsigned int gpio);
-
 #else /* ! CONFIG_GPIOLIB */
 
 #include <linux/kernel.h>
@@ -253,6 +244,23 @@ gpiochip_remove_pin_ranges(struct gpio_chip *chip)
 	WARN_ON(1);
 }
 
+#endif /* ! CONFIG_GPIOLIB */
+
+#ifdef CONFIG_GPIO_DEVRES
+
+/* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
+
+struct device;
+
+int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
+int devm_gpio_request_one(struct device *dev, unsigned gpio,
+			  unsigned long flags, const char *label);
+void devm_gpio_free(struct device *dev, unsigned int gpio);
+
+#else
+
+struct device;
+
 static inline int devm_gpio_request(struct device *dev, unsigned gpio,
 				    const char *label)
 {
@@ -272,6 +280,6 @@ static inline void devm_gpio_free(struct device *dev, unsigned int gpio)
 	WARN_ON(1);
 }
 
-#endif /* ! CONFIG_GPIOLIB */
+#endif
 
 #endif /* __LINUX_GPIO_H */
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fb0fde6..3e84311 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -70,28 +70,6 @@ struct gpio_descs *__must_check gpiod_get_array_optional(struct device *dev,
 void gpiod_put(struct gpio_desc *desc);
 void gpiod_put_array(struct gpio_descs *descs);
 
-struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
-					      const char *con_id,
-					      enum gpiod_flags flags);
-struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
-						    const char *con_id,
-						    unsigned int idx,
-						    enum gpiod_flags flags);
-struct gpio_desc *__must_check devm_gpiod_get_optional(struct device *dev,
-						       const char *con_id,
-						       enum gpiod_flags flags);
-struct gpio_desc *__must_check
-devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
-			      unsigned int index, enum gpiod_flags flags);
-struct gpio_descs *__must_check devm_gpiod_get_array(struct device *dev,
-						     const char *con_id,
-						     enum gpiod_flags flags);
-struct gpio_descs *__must_check
-devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
-			      enum gpiod_flags flags);
-void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
-void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
-
 int gpiod_get_direction(struct gpio_desc *desc);
 int gpiod_direction_input(struct gpio_desc *desc);
 int gpiod_direction_output(struct gpio_desc *desc, int value);
@@ -136,9 +114,7 @@ struct fwnode_handle;
 
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 					 const char *propname);
-struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
-					    const char *con_id,
-					    struct fwnode_handle *child);
+
 #else /* CONFIG_GPIOLIB */
 
 static inline int gpiod_count(struct device *dev, const char *con_id)
@@ -205,69 +181,6 @@ static inline void gpiod_put_array(struct gpio_descs *descs)
 	WARN_ON(1);
 }
 
-static inline struct gpio_desc *__must_check
-devm_gpiod_get(struct device *dev,
-		 const char *con_id,
-		 enum gpiod_flags flags)
-{
-	return ERR_PTR(-ENOSYS);
-}
-static inline
-struct gpio_desc *__must_check
-devm_gpiod_get_index(struct device *dev,
-		       const char *con_id,
-		       unsigned int idx,
-		       enum gpiod_flags flags)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct gpio_desc *__must_check
-devm_gpiod_get_optional(struct device *dev, const char *con_id,
-			  enum gpiod_flags flags)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct gpio_desc *__must_check
-devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
-				unsigned int index, enum gpiod_flags flags)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct gpio_descs *__must_check
-devm_gpiod_get_array(struct device *dev, const char *con_id,
-		     enum gpiod_flags flags)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline struct gpio_descs *__must_check
-devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
-			      enum gpiod_flags flags)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
-{
-	might_sleep();
-
-	/* GPIO can never have been requested */
-	WARN_ON(1);
-}
-
-static inline void devm_gpiod_put_array(struct device *dev,
-					struct gpio_descs *descs)
-{
-	might_sleep();
-
-	/* GPIO can never have been requested */
-	WARN_ON(1);
-}
-
-
 static inline int gpiod_get_direction(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
@@ -417,12 +330,6 @@ static inline struct gpio_desc *fwnode_get_named_gpiod(
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline struct gpio_desc *devm_get_gpiod_from_child(
-	struct device *dev, const char *con_id, struct fwnode_handle *child)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
 #endif /* CONFIG_GPIOLIB */
 
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_GPIO_SYSFS)
@@ -452,4 +359,102 @@ static inline void gpiod_unexport(struct gpio_desc *desc)
 
 #endif /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
 
+#ifdef CONFIG_GPIO_DEVRES
+	struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
+						      const char *con_id,
+						      enum gpiod_flags flags);
+	struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
+							    const char *con_id,
+							    unsigned int idx,
+							    enum gpiod_flags flags);
+	struct gpio_desc *__must_check devm_gpiod_get_optional(struct device *dev,
+							       const char *con_id,
+							       enum gpiod_flags flags);
+	struct gpio_desc *__must_check
+	devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
+				      unsigned int index, enum gpiod_flags flags);
+	struct gpio_descs *__must_check devm_gpiod_get_array(struct device *dev,
+							     const char *con_id,
+							     enum gpiod_flags flags);
+	struct gpio_descs *__must_check
+	devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
+				      enum gpiod_flags flags);
+	void devm_gpiod_put(struct device *dev, struct gpio_desc *desc);
+	void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs);
+
+	struct fwnode_handle;
+	struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
+						    const char *con_id,
+						    struct fwnode_handle *child);
+#else
+	static inline struct gpio_desc *__must_check
+	devm_gpiod_get(struct device *dev,
+			 const char *con_id,
+			 enum gpiod_flags flags)
+	{
+		return ERR_PTR(-ENOSYS);
+	}
+	static inline
+	struct gpio_desc *__must_check
+	devm_gpiod_get_index(struct device *dev,
+			       const char *con_id,
+			       unsigned int idx,
+			       enum gpiod_flags flags)
+	{
+		return ERR_PTR(-ENOSYS);
+	}
+
+	static inline struct gpio_desc *__must_check
+	devm_gpiod_get_optional(struct device *dev, const char *con_id,
+				  enum gpiod_flags flags)
+	{
+		return ERR_PTR(-ENOSYS);
+	}
+
+	static inline struct gpio_desc *__must_check
+	devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
+					unsigned int index, enum gpiod_flags flags)
+	{
+		return ERR_PTR(-ENOSYS);
+	}
+
+	static inline struct gpio_descs *__must_check
+	devm_gpiod_get_array(struct device *dev, const char *con_id,
+			     enum gpiod_flags flags)
+	{
+		return ERR_PTR(-ENOSYS);
+	}
+
+	static inline struct gpio_descs *__must_check
+	devm_gpiod_get_array_optional(struct device *dev, const char *con_id,
+				      enum gpiod_flags flags)
+	{
+		return ERR_PTR(-ENOSYS);
+	}
+
+	static inline void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
+	{
+		might_sleep();
+
+		/* GPIO can never have been requested */
+		WARN_ON(1);
+	}
+
+	static inline void devm_gpiod_put_array(struct device *dev,
+						struct gpio_descs *descs)
+	{
+		might_sleep();
+
+		/* GPIO can never have been requested */
+		WARN_ON(1);
+	}
+
+	struct fwnode_handle;
+	static inline struct gpio_desc *devm_get_gpiod_from_child(
+		struct device *dev, const char *con_id, struct fwnode_handle *child)
+	{
+		return ERR_PTR(-ENOSYS);
+	}
+#endif /* CONFIG_GPIO_DEVRES */
+
 #endif
-- 
2.9.3

