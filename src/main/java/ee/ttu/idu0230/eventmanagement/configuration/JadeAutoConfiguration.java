package ee.ttu.idu0230.eventmanagement.configuration;

import com.github.instaweb.jade.autoconfigure.JadeProperties;
import de.neuland.jade4j.Jade4J;
import de.neuland.jade4j.JadeConfiguration;
import de.neuland.jade4j.template.TemplateLoader;
import ee.ttu.idu0230.eventmanagement.util.TimestampFormatter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Configuration
@ConditionalOnClass(Jade4J.class)
@EnableConfigurationProperties(JadeProperties.class)
public class JadeAutoConfiguration {

    @Resource
    private JadeProperties properties;

    @Bean
    @ConditionalOnMissingBean(JadeConfiguration.class)
    public JadeConfiguration jadeConfiguration(TemplateLoader jadeTemplateLoader) {
        JadeConfiguration configuration = new JadeConfiguration();
        configuration.setCaching(false); //Cache is handled by spring
        configuration.setPrettyPrint(properties.isPrettyPrint());
        configuration.setTemplateLoader(jadeTemplateLoader);
        //configuration.setSharedVariables(sharedVariables);
        //configuration.setFilter(name, filter);
        //configuration.setMode(mode);

        Map<String, Object> shared = new HashMap<>();
        shared.put("timestampFormatter", new TimestampFormatter());
        configuration.setSharedVariables(shared);

        return configuration;
    }

}